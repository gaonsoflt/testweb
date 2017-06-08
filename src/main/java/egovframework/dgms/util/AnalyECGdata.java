package egovframework.dgms.util;

import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by KHS on 2016-09-07.
 */
public class AnalyECGdata {
	//finding R point
    public static final int RATIO_VALUE = 400;
    public static final int RATIO_DURATION = 12; //20에서 12로 변경  40~170 사이
    public static final int UpLimitHR = 100;
    public static final int DownLimitHR = 50;
    public static final int STARTPOINT = 2; //두번째 RR부터 유효값으로 계산한다.

    public int beat;
    public String fname;
    public Date TestDate;
    public String startTime;
    public int MaximumHR;
    public int SecondMaximumRR;
    public int MinimumHR;
    public Date MaximumHRTime;
    public Date SecondMaximumRRTime;
    public Date MinimumHRTime;
    public int AverageHR;
    public int Tachycardia;
    public int Bradycardia;
    public double percentTachycardia;
    public double percentBradycardia;

    public int ArrhymiasCount;

    public byte[] ecg_rawdata;
    public int[] ecg_data;
    public int[] out_data;
    public int[][] point;
    public int[] Rpoint;
    public int data_size;
    public int mode; //20161007
    public int pointCount;
    private ECGdata ECGdata[] = new ECGdata[12000]; //60분동안 최대치 200bmp

    public int Cutoff_Max;
    public int Cutoff_Min;
    public static final double beta = 0.53; //beat 0.5 ~ 0.6

    /**************************************************************
     *
     * 추가 내용 : 데이터를 생성하는 과정이 순서가 중요하므로 내부에서 처리한다.
     * filePath : 파일명까지 포함된 경로
     **************************************************************/
    public static AnalyECGdata CreateECGdata(String filePath) {
        String[] arrTemp = {};
        if (filePath.indexOf(":")>-1)
    	{
        	arrTemp=filePath.split("\\\\");
    	}
        else
        {
        	arrTemp=filePath.split("/");
        }
        
        String strFileName = arrTemp[arrTemp.length-1];
        try{
            FileInputStream fis = new FileInputStream(filePath);
            int rx_count = fis.available();
            byte[] current_ecg_data = new byte[fis.available()];
            while(fis.read(current_ecg_data) != -1) {;}

            long current_position = 16;
            long end_position = fis.getChannel().size();

            AnalyECGdata aECGdata = new AnalyECGdata();

            //HR 계산 알고리즘 시작점.
            aECGdata.ecg_rawdata = current_ecg_data;
            //find RR Interval
            //연산을 위해서 받드시 1,2,3 순서의 함수를 먼저 실행시킬것
            aECGdata.fname = strFileName; // 1. 파일이름입력
            aECGdata.getDate();        //  2. 파일이름으로부터 날짜 가져오기
            aECGdata.findRRInterval(current_position, end_position); // 3. R-R interval을 찾는다.
            aECGdata.getMaximumHR(); //get the Maximum Heat Rate at the time
            aECGdata.getMinimumHR(); //get the Minimum Heat Rate at the time
            aECGdata.getSecondMaximumRR(); //먼저 getMinimumHR()함수를 실행시킬것, //get the Second Maximum RR Interval at the time
            aECGdata.getAverageHR(); //get the average Heat Rate
            aECGdata.getTachycardia(); //get the Tachycardia beats
            aECGdata.getBradycardia(); // get the Bradycardia beats

//            analysisText1.setText(aECGdata.MinimumHR + " Minimum at "+aECGdata.MinimumHRTime);
//            analysisText2.setText(aECGdata.AverageHR + " Average");
//            analysisText3.setText(aECGdata.MaximumHR + " Maximum at "+aECGdata.MaximumHRTime);
//            analysisText4.setText(aECGdata.Tachycardia + " Beats in tachycardia (>100 bpm), "+aECGdata.percentTachycardia + "% total" );
//            analysisText5.setText(aECGdata.Bradycardia + " Beats in bradycardia (<50 bpm), "+aECGdata.percentBradycardia +"% total");
//            analysisText6.setText(aECGdata.SecondMaximumRR + " mSecs Max R-R at "+aECGdata.SecondMaximumRRTime);

            fis.close();

            return aECGdata;
        }
        catch (Exception e) {;}

        return null;
    }

    public void putECGdata(int index, ECGdata putECGdata) {
        ECGdata[index] = putECGdata;
    }

    public void getDate() {
        try {
            SimpleDateFormat transFormat = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
            String fileName = this.fname;
            this.mode = Integer.parseInt(fileName.substring(1,2)); //20161007
            this.startTime = fileName.substring(2, 6) + "." + fileName.substring(6, 8) + "." + fileName.substring(8, 10) + " "
                    + fileName.substring(10, 12) + ":" + fileName.substring(12, 14) + ":" + fileName.substring(14, 16);
            this.TestDate = transFormat.parse(this.startTime);
        } catch (java.text.ParseException ex) {
            ex.printStackTrace();
        }
    }

    /*----------------------------------------------------------------------------------------------
       //       ECG Data Analysis Algorithm
       //       1. Find R-points
       //       2. Calculate Average Heart Rate
       //       3. Minimum Heart Rate
       //       4. Maximum Heart Rate
       //       5. Seconds Max R-R
       //       6. Beats in tachycardia
       //       7. Beats in bradycardia
       ----------------------------------------------------------------------------------------------*/
    public void findRRInterval(long start_position, long end_position) {

        data_size = (int) Math.floor((end_position - start_position - 16) / 2);
        ecg_data = new int[data_size];

        //2bytes 단위의 신호로 변화하여 어레이에 저장
        for (int i = 0; i < data_size - 1; i++) {
            int value01 = (byte) ecg_rawdata[(int) (start_position + 16 + i * 2)];
            int value02 = (byte) ecg_rawdata[(int) (start_position + 16 + i * 2 + 1)] << 8;
            if (value01 < 0) {
                value01 = 256 + value01;
            }
            if (value02 < 0) {
                value02 = 65536 + value02;
            }
            int value0 = value01 + value02;
            ecg_data[i] = value0;
        }

        out_data = new int[data_size];
        highpassfilter(ecg_data, out_data, data_size);
        lowpassfilter(out_data, ecg_data, data_size); //highpass의 출력값을 입력으로 사용
        differential(ecg_data, out_data, data_size); //lowpass의 출력갑을 입력으로 사용

        //Maximum Point
        int max = 0;
        for (int i = 50; i < data_size - 50; i++) {
            if ((max < out_data[i]) && (1000 > out_data[i]))
                max = out_data[i];
        }

        //Second maximum Point
        int secmax = 0;
        for (int i = 50; i < data_size - 50; i++) {
            if ((secmax < out_data[i]) && (max > out_data[i]))
                secmax = out_data[i];
        }

        Cutoff_Max = (int) (secmax * beta); //beat 0.5 ~ 0.6
        //Cutoff_Max = (int)(max * beta); //beat 0.4 ~ 0.5
        Cutoff_Min = (int)(- Cutoff_Max * 1.5);

        //find R-R interval
        findpeakpoint(out_data, data_size);
        findQRSpoint(pointCount, mode); //20161007
        putRpoint(beat);
    }

    public void highpassfilter(int[] InData, int[] OutData, int size) {
        //High pass filter
        int CUTOFF = 20;
        int SAMPLE_RATE = 200;
        double RC = 1.0 / (CUTOFF * 2 * 3.14);
        double dt = 1.0 / SAMPLE_RATE;
        double alpha = RC / (RC + dt);
        OutData[1] = InData[1];

        for (int i = 1; i < size - 1; i++) {
            OutData[i] = (int) (alpha * (OutData[i - 1] + InData[i] - InData[i - 1]));
        }
    }

    public void lowpassfilter(int[] InData, int[] OutData, int size) {
        //High pass filter
        int CUTOFF = 100;
        int SAMPLE_RATE = 200;
        double RC = 1.0 / (CUTOFF * 2 * 3.14);
        double dt = 1.0 / SAMPLE_RATE;
        double alpha = RC / (RC + dt);
        OutData[1] = InData[1];

        for (int i = 1; i < size - 1; i++) {
            OutData[i] = (int) (OutData[i - 1] + (alpha * (InData[i] - OutData[i - 1])));
        }
    }

    public void differential(int[] InData, int[] OutData, int size) {
        for (int i = 0; i < size - 1; i++) {
            OutData[i] = (int) (InData[i + 1] - InData[i]);
        }
    }

    public void findpeakpoint(int[] InData, int size) {
        int pdect = 0;
        int mdect = 0;
        int ndect = 0;
        int dpect = 0;
        int ppterms = 0;
        int pnterms = 0;
        int pmterms = 0;
        point = new int[size / 30][2];
        int jj = 0;
        int detc = 0;


        for (int i = 50; i < size - 50; i++) {
            if (InData[i] >= Cutoff_Max) {
                pdect = 1;
                ppterms = i;
                mdect = 0;
                ndect = 0;
            } else if ((InData[i] <= Cutoff_Max) && (InData[i] >= Cutoff_Min)) {
                ndect = 1;
                pnterms = i;
            } else if (InData[i] <= Cutoff_Min) {
                mdect = 1;
                dpect = 0;
                pmterms = i;
            }

            if ((pdect == 1) && (ndect == 1)) {
                if (pnterms - ppterms <= 12) detc = 300;
                pdect = 0;
            } else if ((ndect == 1) && (mdect == 1)) {
                if (pmterms - pnterms <= 12) detc = 100;
                ndect = 0;
                mdect = 0;
                dpect = 1;
            } else if ((dpect == 1) && (pdect == 1)) {
                if (ppterms - pnterms <= 20) detc = 200;
                pdect = 0;
                dpect = 0;
            }

            if (detc > 0) {
                point[jj][0] = i;
                point[jj][1] = detc;
                jj = jj + 1;
                detc = 0;
            }
        }
        pointCount = jj;
    }

    public void findQRSpoint(int size, int mode) { //20161007
        int j = 0;
        Rpoint = new int[pointCount];
        for (int i = 1; i < size - 2; i++) {
            switch (mode) {
                case 1:
                    //MODE 1로 30초 측정했을 때
                    if (point[i][1] == 300) {
                        j = j + 1;
                        Rpoint[j] = point[i][0];
                        //end
                    }
                    break;
                case 3:
                    //%%%%%%%%%%%%%%%%%%%%% Case 1 : Normal R-S %%%%%%%%%%%%%%%%%%%%%%%%%%%
                    if ((point[i][1] == 300) && (point[i + 1][1] == 100) && (point[i + 2][1] == 100) && (point[i + 3][1] == 200)) {
                        //        if((point(i+3,1)-point(i,1)<=100))
                        //%%%%%%%%%%%%%% Case 2 : abNormal Q-R-S %%%%%%%%%%%%%%%%%%%%%%%%%%%
                        //       if((point(i,2)==200) && (point(i+1,2)==300) && (point(i+2,2)==100) && (point(i+3,2)==100))
                        //         if((point(i+3,1)-point(i,1)<=80))
                        //%%%%%%%%%%%%%%% Case 3 : abNormal R-S %%%%%%%%%%%%%%%%%%%%%%%%%%%
                        //  if((point(i,2)==300) && (point(i+1,2)==100) && (point(i+2,2)==100))
                        // if((point(i+2,1)-point(i,1)<=50))
                        j = j + 1;
                        Rpoint[j] = point[i][0];
                        //end
                    }
                    break;
                default:
                    break;
            }
        }
        beat = j;
    }

    public void putRpoint(int size) {
        int j =0;
        for (int i = 0; i < size - 2; i++) {
            ECGdata curECGdata = new ECGdata();
            if (i > 0) {
                curECGdata.pre_pos = Rpoint[i - 1];
                curECGdata.cur_pos = Rpoint[i];
                curECGdata.RRinterval = (int) (curECGdata.cur_pos - curECGdata.pre_pos);
                curECGdata.HeartRate = (int) (12000 / curECGdata.RRinterval + 0.5);
                //25~250사이의 값만
                if(curECGdata.HeartRate > 25 && curECGdata.HeartRate < 250) {
                    this.putECGdata(j, curECGdata);
                    j= j+1;
                }
            } else {
                curECGdata.pre_pos = 0;
                curECGdata.cur_pos = Rpoint[i];
                curECGdata.RRinterval = 0;
                curECGdata.HeartRate = 0;
                this.putECGdata(j, curECGdata);
                j= j+1;
            }

        }
        beat = j;

    }

    public void getMaximumHR() {
        int max = 0;
        int maxtime = 0;
        //this.getDate();
        Calendar cal = Calendar.getInstance();
        cal.setTime(TestDate);

        for(int i = STARTPOINT;i < this.beat;i++)
        {
            ECGdata tmpECGdata = new ECGdata();
            tmpECGdata = ECGdata[i];
            if ( max < tmpECGdata.HeartRate) {
                max = tmpECGdata.HeartRate;
                maxtime = (int)(tmpECGdata.cur_pos/200);
            }
        }
        // 날짜 더하기
        cal.add(Calendar.SECOND, maxtime);
        MaximumHRTime  = cal.getTime();
        this.MaximumHR = max;
    }

    public void getSecondMaximumRR() {
        int min = 250;
        int mintime = 0;
        int interval = 0;

        //this.getDate();
        Calendar cal = Calendar.getInstance();
        cal.setTime(TestDate);

        for(int i = STARTPOINT;i < this.beat;i++)
        {
            ECGdata tmpECGdata = new ECGdata();
            tmpECGdata = ECGdata[i];
            if( ( min > tmpECGdata.HeartRate)&& (MinimumHR < tmpECGdata.HeartRate)) {
                min = tmpECGdata.HeartRate;
                interval = tmpECGdata.RRinterval;
                mintime = (int)(tmpECGdata.cur_pos/200);
            }
        }
        cal.add(Calendar.SECOND, mintime);
        SecondMaximumRRTime  = cal.getTime();
        this.SecondMaximumRR = interval;
    }

    public void getMinimumHR() {
        int min = 250;
        int mintime = 0;
        //this.getDate();
        Calendar cal = Calendar.getInstance();
        cal.setTime(TestDate);

        for(int i = STARTPOINT;i < this.beat;i++)
        {
            ECGdata tmpECGdata = new ECGdata();
            tmpECGdata = ECGdata[i];
            if ( min > tmpECGdata.HeartRate) {
                min = tmpECGdata.HeartRate;
                mintime = (int)(tmpECGdata.cur_pos/200);
            }
        }
        cal.add(Calendar.SECOND, mintime);
        this.MinimumHRTime  = cal.getTime();
        this.MinimumHR = min;
    }

    public void getAverageHR() {
        int sum = 0;
        for(int i = STARTPOINT;i < this.beat;i++)
        {
            ECGdata tmpECGdata = new ECGdata();
            tmpECGdata = ECGdata[i];
            sum = sum + tmpECGdata.HeartRate;
        }

        this.AverageHR  = (int)(sum/(beat-STARTPOINT+1)+0.5);
    }

    public void getTachycardia() {
        int count = 0;
        for(int i = STARTPOINT;i < this.beat;i++)
        {
            ECGdata tmpECGdata = new ECGdata();
            tmpECGdata = ECGdata[i];
            if(tmpECGdata.HeartRate > UpLimitHR) count++;
        }

        this.Tachycardia = count;
        this.percentTachycardia = Tachycardia*100/(beat-STARTPOINT+1);
    }

    public void getBradycardia() {
        int count = 0;
        for(int i = STARTPOINT;i < this.beat;i++)
        {
            ECGdata tmpECGdata = new ECGdata();
            tmpECGdata = ECGdata[i];
            if(tmpECGdata.HeartRate < DownLimitHR) count++;
        }

        this.Bradycardia = count;
        this.percentBradycardia = Bradycardia*100/(beat-STARTPOINT+1);
    }

    public void findArrhythmias() {
        int count = 1;
        int mintime = 0;
        int start = STARTPOINT;
        int end = 0;

        ArrhymiasCount = 0;
        for(int i = STARTPOINT;i < this.beat;i++)
        {
            ECGdata tmpECGdata = new ECGdata();
            tmpECGdata = ECGdata[i];
            mintime = (int)(tmpECGdata.cur_pos/200);
            if(mintime > 10*count) {
                count++;
                end=i;
                AnalyArrhymias(start, end, end-start);
                start = end;
            }
        }
    }

    public void AnalyArrhymias(int start, int end, int count) {
        int sumDiffRRinterval = 0;
        int DiffRRinterval = 0;
        for(int i = start;i < end-1;i++)
        {
            ECGdata tmpECGdata = new ECGdata();
            tmpECGdata = ECGdata[i];
            int curRRinterval = tmpECGdata.RRinterval;
            tmpECGdata = ECGdata[i+1];
            int nextRRinterval = tmpECGdata.RRinterval;
            if(curRRinterval > nextRRinterval) {
                sumDiffRRinterval += curRRinterval - nextRRinterval;
            }else {
                sumDiffRRinterval += nextRRinterval - curRRinterval;
            }
        }
        DiffRRinterval = sumDiffRRinterval/(count-1);
        if(DiffRRinterval > 17)ArrhymiasCount++;
    }
}
