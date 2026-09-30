Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EDE34F27B
	for <damon@lists.linux.dev>; Wed, 30 Sep 2026 04:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790741043; cv=pass; b=mfIeITEJIsh1PDJuBIozHgtWq19kK96NKQYe0lAugGx+2Nf116LpY12Vfu6LnZnxaaUk4UgjUZ33ssUY0fFzGwPxpmicrPHiX/TzKcyHXyeoRfXIymONKqst6iFFUzZgnDcOGt9bI3N24w/JQwbUQyyuppz6M8C0bkPySSRALWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790741043; c=relaxed/simple;
	bh=8nhlo9mhacv+/Ad51v75P6cUGfqTbXwnoRK+/IYk1yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0nQXAv/A+zw6N/lPgyKyFOikbzTwBusSv8KAjtX4pprLYeU6peTYs96BArjpY7ZzL2Ew6Yk7VWVInbN+uf+KdyqqlNO5Xnyt6bpd1jNudePZIb15yUCHXIWnBmOiAv2rLs++j8ip75kgjrA+kAMAGpS80jVouLA0MWSxZCl5MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBzs8Ir/; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBzs8Ir/"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2e20bb4583so18830866b.3
        for <damon@lists.linux.dev>; Tue, 29 Sep 2026 21:04:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790741039; cv=none;
        d=google.com; s=arc-20260327;
        b=oiqlOkb8Y2sYQJ9HkKp6CLmFzvluW00KcOcmkUCn/hX9mok0hvQuq9OeNGUV9aRxlB
         wauhEKZZZQB7REiomPfqJIwgPfLYVm3cOUnewrT6kxxManWcLkkdsmsacyqfB5JE1Rxv
         1ioFplkQGfzMuLPeV5bpaVeH0pexXSgpgAaUR5QB2hxS2Zb8kIr8gU/wXEejVl1tCC6m
         rTJjx4vzJ2Nu6ijC7TWMG+uJkmJOpfoh/SB5niOE/TlAomZu91Mwzpmo5mbHeCqAghlv
         bYNpkhmPae53+PD5yqDZUXLIY+KoJGfppit+xoHZOypXkhjmmGvmPMhE+sTbpMWoJqNm
         sSFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Tbn6LMqZgrNII0IW7BYLb9D0hmeO9xzvyjOyDfYn9Zg=;
        fh=e+kRStJq+twn6rlp7glLc6kIxtYd+ofNVnbBqiY9oQA=;
        b=ON4H/N3vfZnbC1GQ4PV6MTWbedOqMKSH2pkh3PlFGnMH+MEGbhwC3GZyd3pR+I/g31
         jSDxNFb2tU+/ZmBguc/QlSz0kwFzQrsRAt11oWuHubBzTu5grLtYEI/6SX0nBnNVjGIh
         Gke7ZWKrtuLFhjT9XWTeqcKnnZQV9ZeIyKD+kBEmZIX39pU0g9XDkKUB6fcs0SNaeNnS
         0YAEOF+mSTWQebB2uT4GTWIiFhr9TXVfcwHlHRkJJKGAEM5NnuUU1FXJxwSQF7c+R7+S
         14F+HclCEvdmrvIgocLQ6PzcLLmwgIi67k+MTvcH5X37CwTFgcfsLgSH9C2tRLAofWA/
         k8ug==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790741039; x=1791345839; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tbn6LMqZgrNII0IW7BYLb9D0hmeO9xzvyjOyDfYn9Zg=;
        b=RBzs8Ir/BKa41SL4Kht5cFk+I5aMI8ZH4Ax1Cs0BWvrh1B4RZh6Z7+KX4mWhJidGpl
         YE2slUMWyYR+4VFfjXedEjVQU0v9x/o+aMKJx5WWt7dZ3xAIoKW/LIA7Q5+Pk4Ms5Yf7
         k6Sdi68e+UgKr66zajBjqMaCZr9WNtSjRPbNp1pvnm7R0JsUl26D4MY37bsqsZ9YqGSz
         uctiu+lgFK7bMyTDaf9FNIQO3Rk9i+sS4aIKUR4dTDn1eL5l5mxBZywGOmks17zvz53t
         mrWsYXuIwMET7FMteclGFTlf0KqBk30lbPlY7ukjTKGP1YFq4eah/M9IpimL4uYsQ+EM
         KiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790741039; x=1791345839;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Tbn6LMqZgrNII0IW7BYLb9D0hmeO9xzvyjOyDfYn9Zg=;
        b=1mk56AHlsK8oGOMjBl0zxCWqCTUcA9gXOY9Ts7b8hbBj10ofB84Y1pMZRDfmz3SPj+
         jH6LWVA5a1HVnRdlCaCPqlQeWjztNup3LVzuZygK6+PHwupo0xygVj+Lj0uu/akRgkKT
         AGZUb8oil0CGirILqg3IQvnmaVLCPC67pgtS9vu7gxEvWopSUcWQSogJgmF+9PoPSmWy
         Ht5V15lPdSuv6CM587MLLFzHNbn2nQR1a/DYBpEq6I0t8eKlzeG2/LqYpvSXNpy2Op6R
         RfmOKsri9Pd0ztWVMHYf0QUmrLHulSFDNO1UfF+CnePcRyBtnFfYxdDmBeEHCfHFvVKN
         9Xtw==
X-Gm-Message-State: AFq9FYKhb6FaPEIfoEemY/qPC3RDeP21rol67bQd1Ig4ZJqLwPwPUVdf
	KQqP+Vpb2DUFoJmqk3DT9LR+P3eTwHP7EH+DzeiJI12lDbFMhZ4UaptE36mLeD0J9BZNyxbZGID
	eTUZkAVwToCkJOOIZzA3B9jBcfbFdLJPKdv6R
X-Gm-Gg: AYBFou0gIk0gC6Rup5c9QmCcNt2haaC136xuVI98jSHuTM9+dIipkpBVCz1BtT1dkQT
	fKiB59N1cGEjDxIQeTjhIW0vU9VIivcXt6QqdcGe9HduuOk4eoyK7qKSwMU509Fh3kxMRx4z1tc
	zpTrSq5nlly8hlwLWg9v2fIn848l3Ne6S195wA1a36fyB69AFDxEe2HV2X6cjBX/uCgdqeC0h6F
	FkOvB7UyrpKEm+/FfCYN0oStPV68kXPio7ci7SAjl9MnbgETcfe1F5F7m/Hjf8fJ5qIiERjcHcj
	rTmbTT/+PzGyhS0s3P1sYJZ3rXZs/9ffCDepCLStwVbL7Sui/m1VAsJPSIztqXVextA=
X-Received: by 2002:a17:906:9fc8:b0:c19:45e3:2f57 with SMTP id
 a640c23a62f3a-c2e23ca351cmr4153666b.9.1790741039282; Tue, 29 Sep 2026
 21:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAiJnjrSKe9r7KXnWzrgb1-CRO0sDu7B_jK2mZDg7fPaT0Jdcg@mail.gmail.com>
 <20260929173721.6763-1-sj@kernel.org>
In-Reply-To: <20260929173721.6763-1-sj@kernel.org>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Wed, 30 Sep 2026 07:03:47 +0300
X-Gm-Features: AclHuK-zBcGSwjuyAR_VY7FkLn-4r1bAoDeS5BpOAU1DvtPEJWm6bhloMSwxXFM
Message-ID: <CAAiJnjq_XJ+kvNFdbXNJUrJMVtj5BVqN+NoZ2PvxYavFjOg2fw@mail.gmail.com>
Subject: Re: Memory tiering with DAMON/DAMOS auto-tuning
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Content-Type: multipart/mixed; boundary="0000000000008837bf065cab6357"

--0000000000008837bf065cab6357
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Oops...  Seems you were running next branch of damo.  There was a bug.  I
> reproduced it on 7.2.8 kernel, and fixed it.  The fix [1] is now pushed. =
 Could
> you pull the 'next' branch and try again?

Done.

Ok, initially I have,

[root@localhost ~]# numastat -z -p $(pgrep valkey-server)

Per-node process memory usage (in MBs) for PID 25361 (valkey-server)
                           Node 0          Node 1          Node 2
                  --------------- --------------- ---------------
Heap                         0.11            0.00            0.00
Stack                        0.03            0.00            0.00
Private                 238356.60            0.50            4.86
----------------  --------------- --------------- ---------------
Total                   238356.73            0.50            4.86

                            Total
                  ---------------
Heap                         0.11
Stack                        0.03
Private                 238361.95
----------------  ---------------
Total                   238362.09
[root@localhost ~]#

I run

/home/anton/damo/damo start \
        ` # A kdamond to demote cold memory from node 0 to node 2 ` \
        --kdamond --damon_ctx --monitoring_intervals_autotune \
                --damon_target --numa_node 0 \
                --damos_scheme \
                        --damos_action migrate_cold 2 \
                        --damos_access_rate 0% 0% --damos_apply_interval 1s=
 \
                        ` # up to 8 GiB per second ` \
                        --damos_quota_interval 1s --damos_quota_space 8G \
                        ` # aiming at least 50% node 0 free memory ` \
                        --damos_quota_goal node_mem_free_bp 50% 0 \
                        ` # using temporal tuner ` \
                        --damos_quota_goal_tuner temporal \
                        --damos_filter reject young \
        ` # A kdamond to promote hot memory from node 2 to node 0 ` \
        --kdamond --damon_ctx --monitoring_intervals_autotune \
                --damon_target --numa_node 2 \
                --damos_scheme \
                        --damos_action migrate_hot 0 \
                        --damos_access_rate 5% max --damos_apply_interval 1=
s \
                        ` # up to 8 GiB per second ` \
                        --damos_quota_interval 1s --damos_quota_space 8G \
                        ` # aiming at least 50.3% node 0 memory utilization=
 ` \
                        --damos_quota_goal node_mem_used_bp 50.3% 0 \
                        ` # using temporal tuner ` \
                        --damos_quota_goal_tuner temporal \
                        --damos_filter allow young \
>
>
[root@localhost ~]# ps -ef|grep -i dam
root       29836       2  2 06:37 ?        00:00:00 [kdamond.0]
root       29837       2  0 06:37 ?        00:00:00 [kdamond.1]
root       29842   29644  0 06:37 pts/2    00:00:00 grep --color=3Dauto -i =
dam
[root@localhost ~]# cat
/sys/kernel/mm/damon/admin/kdamonds/1/contexts/0/schemes/0/quotas/goal_tune=
r
temporal
[root@localhost ~]# cat
/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/schemes/0/quotas/goal_tune=
r
temporal
[root@localhost ~]#


> It would also be helpful if you could run 'damo report damon --damos_stat=
s'
> periodically (say, once per 5-10 seconds) while the migration is ongoing =
and
> share the outputs with us.

Sure, I will start something like that,
while true; do /home/anton/damo/damo report damon --damos_stats >>
/home/anton/damo_report_damon_damos_stats; sleep 10; done
once damo will be started.
Please check the attached file.
It looks now it keeps ~50% free numa node 0,

[root@localhost ~]# numastat -z -p $(pgrep valkey-server)

Per-node process memory usage (in MBs) for PID 25361 (valkey-server)
                           Node 0          Node 1          Node 2
                  --------------- --------------- ---------------
Heap                         0.05            0.00            0.06
Stack                        0.01            0.00            0.02
Private                 138725.66            0.50        99635.75
----------------  --------------- --------------- ---------------
Total                   138725.71            0.50        99635.82

                            Total
                  ---------------
Heap                         0.11
Stack                        0.03
Private                 238361.90
----------------  ---------------
Total                   238362.04
[root@localhost ~]#



> Interesting.  I doubt if the tuner change is correctly made.  'damo repor=
t
> damon' can help us understand under what configuration DAMON is running. =
 It
> could help us quickly see if the configuration is done as we intended.  C=
ould
> you share 'damo report damon' result on the final state?

[root@localhost ~]# /home/anton/damo/damo report damon
kdamond 0
    state: on, pid: 29836
    context 0
        ops: paddr
        target 0
            pid: 0
            region [4,096, 581,632) (564.000 KiB)
            region [589,824, 655,360) (64.000 KiB)
            region [1,048,576, 2,079,305,728) (1.936 GiB)
            region [2,079,363,072, 2,153,725,952) (70.918 MiB)
            region [2,153,926,656, 2,154,790,912) (844.000 KiB)
            region [2,154,811,392, 2,154,909,696) (96.000 KiB)
            region [2,154,930,176, 2,354,724,864) (190.539 MiB)
            region [2,355,859,456, 2,355,871,744) (12.000 KiB)
            region [2,372,751,360, 2,372,755,456) (4.000 KiB)
            region [2,372,759,552, 2,372,771,840) (12.000 KiB)
            region [2,391,846,912, 2,551,230,464) (152.000 MiB)
            region [2,604,707,840, 2,604,716,032) (8.000 KiB)
            region [2,605,244,416, 2,944,397,312) (323.441 MiB)
            region [2,944,397,372, 2,944,401,408) (3.941 KiB)
            region [4,294,967,296, 413,390,602,240) (381.000 GiB)
        intervals
            sample 5.120 s, aggr 1 m 42.400 s, update 1 s
            target 4 % accesses per 3 aggrs, [5 ms, 10 s] sampling interval
        nr_regions: [10, 1,000]
        scheme 0
            action: migrate_cold to node 2 per 1 s
            target access pattern
                sz: [0 B, max]
                nr_accesses: [0 samples, 0 samples]
                age: [0 aggr_intervals, 184,467,440,737,095 aggr_intervals]
            quotas
                0 ns / 8.000 GiB / 0 B per 1 s
                goal 0: metric node_mem_free_bp (nid 0) target 5,000 curren=
t 0
                goal tuner: temporal

                priority: sz 0.1 %, nr_accesses 0.1 %, age 0.1 %
            watermarks
                metric none, interval 0 ns
                0 %, 0 %, 0 %
            filter 0
                reject young
            statistics
                tried 142 times (560.000 GiB)
                applied 55 times (97.342 GiB)
                97.351 GiB passed filters
                quota exceeded 234 times
                97.351 GiB
                tried 0 snapshots (max 0)
            tried regions (0 B)
        access sample control
        enabled primitives: page_table
kdamond 1
    state: on, pid: 29837
    context 0
        ops: paddr
        target 0
            pid: 0
            region [466,003,951,616, 3,646,427,234,304) (2.893 TiB)
        intervals
            sample 10 s, aggr 3 m 20 s, update 1 s
            target 4 % accesses per 3 aggrs, [5 ms, 10 s] sampling interval
        nr_regions: [10, 1,000]
        scheme 0
            action: migrate_hot to node 0 per 1 s
            target access pattern
                sz: [0 B, max]
                nr_accesses: [1 samples, 3,689,348,814,741,910,528 samples]
                age: [0 aggr_intervals, 184,467,440,737,095 aggr_intervals]
            quotas
                0 ns / 8.000 GiB / 8.000 GiB per 1 s
                goal 0: metric node_mem_used_bp (nid 0) target 5,030 curren=
t 0
                goal tuner: temporal

                priority: sz 0.1 %, nr_accesses 0.1 %, age 0.1 %
            watermarks
                metric none, interval 0 ns
                0 %, 0 %, 0 %
            filter 0
                allow young
            statistics
                tried 0 times (0 B)
                applied 0 times (0 B)
                0 B passed filters
                quota exceeded 150 times
                0 B
                tried 95 snapshots (max 0)
            tried regions (0 B)
        access sample control
        enabled primitives: page_table
damon_reclaim: off
damon_stat: off
[root@localhost ~]#


DAMON & DAMOS are very flexible, so it requires a deep understanding
of specific workload and how to configure memory tiering with DAMON &
DAMOS.

So firstly I decided to make it like VMware VCF 9.1 does :-)), next I
will reduce the goal from 50% free to 25-25% for numa node 0.

Based on the outputs above, please let me know if other improvements
are required.


Anton

=D0=B2=D1=82, 29 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 20:3=
7, SJ Park <sj@kernel.org>:
>
> On Tue, 29 Sep 2026 16:54:41 +0300 Anton Gavriliuk <antosha20xx@gmail.com=
> wrote:
>
> > > Also, fyi again, from damo v3.4.1, you can mark start of new kdamond,=
 context,
> > > target and scheme parameters on the command line using --kdamond, --d=
amon_ctx,
> > > --damon_target, and --damos_scheme.  you coud use those instead of
> > > --damos_nr_quota_goals, --damos_nr_filters, --nr_targets, --nr_scheme=
s and
> > > --nr_ctxs.  E.g.,
> >
> > Fedora shows old damo version,
> >
> > [root@localhost anton]# rpm -qa|grep -i damo
> > damo-3.3.0-1.fc44.noarch
> > [root@localhost anton]#
> >
> > so I configured latest available 3.4.1
> >
> > [root@localhost damo]# damo version
> > 3.4.1
> > [root@localhost damo]# which damo
> > /home/anton/damo/damo
> > [root@localhost damo]#
>
> Thank you!  Hopefully upgrading the version was not that difficult.  You =
can
> simply git-clone the repo and use the 'damo' executable file under the
> local-cloned repo.
>
> >
> > > Seems you manually made this change.  Has this executed after 'damo s=
tart'?
> > > Also, did you 'commit' the updated commit input?  If any of your answ=
er to the
> > > questions is not "yes", the tuner update may not applied.
> >
> > Yes, it was executed before 'damo start', but I didn't do 'commit'.
>
> To do this manually, you should write the files after 'damo start', and a=
lso do
> 'commit'.
>
> Anyway, this means your previous run was using 'consist' tuner.  That exp=
lains
> why it didn't show any difference.
>
> >
> > > It would also be helpful if you could run 'damo report damon --damos_=
stats'
> > > periodically (say, once per 5-10 seconds) while the migration is ongo=
ing and
> > > share the outputs with us.
> >
> > Ok, initially I have,
> >
> > [root@localhost ~]# numastat -z -p $(pgrep valkey-server)
> >
> > Per-node process memory usage (in MBs) for PID 25361 (valkey-server)
> >                            Node 0          Node 1          Node 2
> >                   --------------- --------------- ---------------
> > Heap                         0.11            0.00            0.00
> > Stack                        0.03            0.00            0.00
> > Private                 238356.60            0.50            4.86
> > ----------------  --------------- --------------- ---------------
> > Total                   238356.73            0.50            4.86
> >
> >                             Total
> >                   ---------------
> > Heap                         0.11
> > Stack                        0.03
> > Private                 238361.95
> > ----------------  ---------------
> > Total                   238362.09
> > [root@localhost ~]#
> >
> > I run
> >
> > [root@localhost ~]# /home/anton/damo/damo start \
> >         ` # A kdamond to demote cold memory from node 0 to node 2 ` \
> >         --kdamond --damon_ctx --monitoring_intervals_autotune \
> >                 --damon_target --numa_node 0 \
> >                 --damos_scheme \
> >                         --damos_action migrate_cold 2 \
> >                         --damos_access_rate 0% 0% --damos_apply_interva=
l 1s \
> >                         ` # up to 8 GiB per second ` \
> >                         --damos_quota_interval 1s --damos_quota_space 8=
G \
> >                         ` # aiming at least 50% node 0 free memory ` \
> >                         --damos_quota_goal node_mem_free_bp 50% 0 \
> >                         ` # using temporal tuner ` \
> >                         --damos_quota_goal_tuner temporal \
> >                         --damos_filter reject young \
> >         ` # A kdamond to promote hot memory from node 2 to node 0 ` \
> >         --kdamond --damon_ctx --monitoring_intervals_autotune \
> >                 --damon_target --numa_node 2 \
> >                 --damos_scheme \
> >                         --damos_action migrate_hot 0 \
> >                         --damos_access_rate 5% max --damos_apply_interv=
al 1s \
> >                         ` # up to 8 GiB per second ` \
> >                         --damos_quota_interval 1s --damos_quota_space 8=
G \
> >                         ` # aiming at least 50.3% node 0 memory utiliza=
tion ` \
> >                         --damos_quota_goal node_mem_used_bp 50.3% 0 \
> >                         ` # using temporal tuner ` \
> >                         --damos_quota_goal_tuner temporal \
> >                         --damos_filter allow young \
> > >
> > sysinfo loading fail (info update fail (sysfs feature check fail
> > (feature map making fail (staging damos goal feature check purpose
> > kdamond failed))))
>
> Oops...  Seems you were running next branch of damo.  There was a bug.  I
> reproduced it on 7.2.8 kernel, and fixed it.  The fix [1] is now pushed. =
 Could
> you pull the 'next' branch and try again?
>
> > [root@localhost ~]#
> > [root@localhost ~]# ps -ef|grep -i damo
> > root       26051   25396  0 16:49 pts/2    00:00:00 grep --color=3Dauto=
 -i damo
> > [root@localhost ~]#
> >
> > > It would also be helpful if you could run 'damo report damon --damos_=
stats'
> > > periodically (say, once per 5-10 seconds) while the migration is ongo=
ing and
> > > share the outputs with us.
> >
> > Sure, I will start something like that,
> > while true; do damo report damon --damos_stats >>
> > /home/anton/damo_report_damon_damos_stats; sleep 10; done
> > once damo will be started.
>
> Sounds good.
>
> >
> >
> > > Interesting.  I doubt if the tuner change is correctly made.  'damo r=
eport
> > > damon' can help us understand under what configuration DAMON is runni=
ng.  It
> > > could help us quickly see if the configuration is done as we intended=
.  Could
> > > you share 'damo report damon' result on the final state?
> >
> > There are errors above during damo start.
>
> Apparently it was a bug in damo's next branch.  As I mentioned above, the=
 fix
> is now pushed.  Could you try again?
>
> [1] https://github.com/damonitor/damo/commit/fd2fb55b44ba03db55b8a025eef4=
3dcf569831e5
>
> Thanks,
> SJ
>
> [...]

--0000000000008837bf065cab6357
Content-Type: application/x-gzip; name="damo_report_damon_damos_stats.gz"
Content-Disposition: attachment; filename="damo_report_damon_damos_stats.gz"
Content-Transfer-Encoding: base64
Content-ID: <f_munkyspb0>
X-Attachment-Id: f_munkyspb0

H4sICM2FvGoAA2RhbW9fcmVwb3J0X2RhbW9uX2RhbW9zX3N0YXRzANWaTW7bMBCF9z6FTqByyBn+
dNlNVz2DYdgqYiSxHUsLo6cv6aYCaVGsCNhwZxeLA+Hly2TeGyavu8378bBrRPOl2R4PQ3cZrl/3
25fuvWvE6nBeD+d9t/vakFz1v/5+AGlbIUTzff8tlGxOp7c/z1UoGj9ia5Vufvgi//R46tc/929D
d16fNn0fzs14/jGsu8u263a9fwmFd/aHzal/OQ7+gVi9by7r22er10/x8G/xItIumlSzSCSH07zY
cJLIdHUyFzDWsU4wOstYQiLY/yCICowBxoJYvX8LB8gS7w/ZRTqlklnIKhUMsiWDJco0FiTyLQvK
Stydskkou3wrK0opY+uw2MtmLEjkax6UK5thAWUXU1Y008s6ESylH7uihFkqNVbE3wAqFpyx0j8W
cAaBMWiLedDmdjJbdy3K6/bnjq7niXrDAjLdv5lB6Biym+lml84MP1mgRDkUyAxmHpNZ3z9kgDCR
UBQiixlTxVK17pPi3MxonYIp5kr9T8JsHoHZJpjzgRnTMKfAD15TwBwKQE0wU6WBPwmzu3/OABFb
IEI+aKBMMbtWlzH7ghxmHqEZxAM4Q6wUZd4B8Wb/M62yssD5WmCnnCUPzvAAzgpiznZmOqeRDq0f
viUTDAWY4cxjOgNUZqJFnOOwQXKGcxo2yLYoS/0cCjIuqCu32GdxlpWL1CLONuGct0FKbVDrVhZD
XSiQ037WTG6OVKWPLOIc+yCpvA9S6oPGhzbSBc6hQOOUM4+FG2ovBpZwxlgpYd4HKfVBC60p5o1Q
ANMlRfPYBQEr/XoR59gHaeZqgzDl7FrUxZXbF5jM3OCxDELt3cAizvG9Pum8D1J6Ued8bMOSD4YC
yvggk7wxWacUL86GydyYcLa8OFuunIFZQzsmgWMK2vACHS66eZKWkhlpYEuaW0/X/hH5vyGtmOU7
UEwW8ClpZoYY1iOmpIkbaa7ZQzFL08Dl2n9C2v8yMiPN5MJjSprbnNY8/mcmQ1pzI831cgm5zWnD
taeJW542XOc0cZvTluuOSNzytGXb0zP3Hr8BtZcIxUUxAAA=
--0000000000008837bf065cab6357--
