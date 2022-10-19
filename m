Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE831FC9
	for <damon@lists.linux.dev>; Wed, 19 Oct 2022 02:49:59 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id k9so15215791pll.11
        for <damon@lists.linux.dev>; Tue, 18 Oct 2022 19:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wUd/MGTvQfTnwEOK6nXZY2PdLyfAu6WiBr91nkDhpXI=;
        b=Fb0ThL3P12V9lC3il+a3vsDIjksNEJp26sJGq5lOiYpe16KzVDyjlMJ3ejx2jQevhT
         bS4nGUO3c3tz7bnOW7YaUyShH77m5MvRz8B0F3aMlEN+7eMGt2hTbF4PJF2kl64bLK8n
         eFni3jwCIkSXDxTpnG5upVFyI19kdxqso8pK/Og4GcjHA2k6OZrnOK98vLazkGQwqk7J
         /V0bBQzYDEbrQdK9gkSVSePBL8bMZyF915AG/cYz2rlhBPTP9BRbQTZ4+xVfQTGEwVrS
         Mj4LabyLKplHPPr49nwVHZEkFpEr2lHvlLfS917zHV9Hlf8TGFzrh21/uJmg0svQyNKX
         n2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wUd/MGTvQfTnwEOK6nXZY2PdLyfAu6WiBr91nkDhpXI=;
        b=A1II4n5X/iy2HpHOYXUXE/81wS1LUzXHDiYWtqQnosMv+wwBMqQ//iOljFHbZAQ0aN
         RBWQR8tfGymF/IJ4HFbKYKuN4vT3wGMdID7UkyHuqYtJJ+PyvJ/NdBHkkNC6pZsfTOtR
         F1mLl9lbTWRjm/nLLSogL+6+Ovh1dF0VgfhVyGjPAp3yDrs4oYCf0DIFaR/6KfHHakIk
         5v/zo6HNwAVidYSPYnZEA3lMOhYiVcz3AX4hlt77rrKnGxLD10Kd1UfX6hoikR1X3awO
         VEDNqGGeZJgp79akZ8IlJG/+9+p2HwprVl0fa1+o4p6fvebdkd/dse3MpYX9WhxKBuD/
         PdBQ==
X-Gm-Message-State: ACrzQf2A1xQtHx7UrMKzuog8pSF3kTqD/kAyZCGnHgFi7CIyfoucCSHU
	xWzpo1edyC6OQLfGLPNpOmm/io7fFE5BlRVyoXdpu4xRGjM=
X-Google-Smtp-Source: AMsMyM5/A4sTx/j24uk3Tl+Eqllidlnoi1/Hxdt/yH++43fYJhmBCX7Dd2q8MT/JcxouuaBSOULwRszBpCm1gUOJ+84=
X-Received: by 2002:a17:90b:4a4d:b0:20d:4dc7:fa72 with SMTP id
 lb13-20020a17090b4a4d00b0020d4dc7fa72mr6822698pjb.86.1666147798739; Tue, 18
 Oct 2022 19:49:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Vinicius Petrucci <vpetrucci@gmail.com>
Date: Tue, 18 Oct 2022 21:49:22 -0500
Message-ID: <CAEZ6=UNUcH2BvJj++OrT=XQLdkidU79wmCO=tantSOB36pPNTg@mail.gmail.com>
Subject: Issue while testing new fvaddr feature
To: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

I am experimenting with the new fixed address (fvaddr) feature of
DAMON to monitor memory regions originated from user-level mmap/malloc
calls.
I used "strace" to intercept the mmap calls and derive "start" and
"end" attributes for monitoring using the "masim" program
(https://github.com/sjp38/masim) as an example that creates two memory
allocations and keeps accessing them for a long time.
Then, I used "perf record" to get the data, but perf doesn't seem to
be recording anything. Nothing is shown after issuing "perf script".

Could you please help me spot any mistakes with my tests (if any)
using the Bash script below? Could also please let me know whether or
not that is reproducible in your system?

I am using kernel 6.0.2 and I checked that "fvaddr" is supported via
"damo features".
All steps in the script below ("test-fvaddr-damon.sh") runs without
any errors. It is just that nothing appears in the perf data.

-------- test-fvaddr-damon.sh --------------

strace -e mmap ./masim/masim hint_test_inf 2> strace.out &


sleep 2


echo 1 > /sys/kernel/mm/damon/admin/kdamonds/nr_kdamonds
echo 1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/nr_contexts

echo fvaddr > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/operations

echo 1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/nr_targets

echo $(pidof masim) >
/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/pid_target

echo on > /sys/kernel/mm/damon/admin/kdamonds/0/state



start1=`cat strace.out | tail -2 | head -1 | cut -f2 -d=`

start2=`cat strace.out | tail -2 | tail -1 | cut -f2 -d=`



# convert to decimal

start1=$((${start1}))

start2=$((${start2}))



size1=`cat strace.out | tail -2 | cut -d, -f2 | head -1`

size2=`cat strace.out | tail -2 | cut -d, -f2 | tail -1`



end1=$(($start1+$size1-1))

end2=$(($start1+$size1-1))



echo $start1 $end1

echo $start2 $end2



echo 2 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/nr_regions



echo $start1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/0/start

echo $end1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/0/end



echo $start2 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/1/start

echo $end2 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/1/end



perf record -e damon:damon_aggregated &



sleep 15



kill $(pidof perf)



echo off > /sys/kernel/mm/damon/admin/kdamonds/0/state



perf script



killall strace

----------- hint_test_inf -------------

#regions

# name, length

a, 1073741824 # 1 GiB

b, 1073741824 # 1 GiB



# phase 1

# name of phase

phase 1

# time in ms

9999999999999

# access patterns

# name of region, randomness, stride, probability

a, 0, 64, 99

b, 0, 64, 1



# phase 2

phase 2

# time in ms

10000

# access patterns

# name of region, randomness, stride, probability

a, 0, 64, 1

b, 0, 64, 99


Thank you!
