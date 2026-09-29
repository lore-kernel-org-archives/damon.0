Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2EA52CCC4
	for <damon@lists.linux.dev>; Tue, 29 Sep 2026 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790690098; cv=pass; b=ra4mlMzjyYtmNcCcjojH0Xjxvz28PbrGn1RHWlkzIZOI6ZRRaK26FvnHWLiY3xi7lo2MCq5bm4XEan9nm+ZZd3zSP9izSxJ5uSVAkBucN+n9oQyaj1sOcebjWGyPjwXaa0nTLEsCjSuZ4CA83sHhoG0rC6XOwWtYpr3nlwEa1NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790690098; c=relaxed/simple;
	bh=DOpAfVQMn3r3vumFuSeQTbDF1KECyXMt0ptr3y4YLKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7zoHqBEJQdfYYdG1v9yj+d6fKfxyZggQ77QjlvPQ+ircYCR2kMciITGySiyIA/UgvhS0DQehmgBgHIjLtTR3YV6FyBP0fC3Y/TD2LjE0K7dxISPYaOmoGT0hFxD/RQBnQUcVuIkaAsDk5xL7us3AaUKqcoKGobEa3qkzl0Q0IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiKXRRP+; arc=pass smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiKXRRP+"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6abc27842b6so4514088a12.3
        for <damon@lists.linux.dev>; Tue, 29 Sep 2026 06:54:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790690095; cv=none;
        d=google.com; s=arc-20260327;
        b=moRAY2Zh3ONgra0aLjq1VVXuYBdSkvpDYtQMYlyL/TOOrrWRuyz23Ioc7otvgUlZ9X
         NrUqN9OzT5Si2qvitVoOuNeSnDIPnZ4j6+UaUdMA+Nva0WaoWq+cHByip5FeNPP17Ytg
         4pcXgh/PS7tagPrCIXOq/HSKM1ApK9N0c4Zhc6tZxQIlsNMJfTv+xsKezEYUuAK/scp+
         1QZQ5qTq8pnTuLGiC/G6PQujhGn7tNacqy0BHWXBxDTa/4OGplmYobLr1PX8kqCyhx13
         GG24XxFOh94O7Z047ZoUfhTxn04Cvdk2UcyWQA/1uYlajeFytNF80woFImUfuJxdS8Tz
         jSQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/LI7Cx4rq7BtYr5e7cmDHzgqGSmRco6KSC9LU6lXIOw=;
        fh=e+kRStJq+twn6rlp7glLc6kIxtYd+ofNVnbBqiY9oQA=;
        b=Q9EdgOPPuTKFe5TwunAbzycamLo3Q1UB+KCHnGtHBqphCQygskcwO2IXORYNxOq4oU
         g4/s4c4Y+urOsvH5nhUbLlxAoAg0eex0tOwAeHLxQH+LUPsy5l6tif6v83lWLA7iEODO
         /fRuq1N4nuHdjyQWtZJBI4Opzb5FhQwNsMgbN99gBigDSM4fwMqOOQF6TUuLUukSak53
         PwiruDc1XzGnSxA8NnnemuEAdRdckRbZe8XwXys+nPwipXaveb1t+RyR85sUUuq2VG71
         qTSey2hxXBxFZ5GwGd+8ZMKQDZV28R5S/F/mcfv9xwGUwoinVfdxiGWfF4PPJUzAxFEn
         4c+Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790690095; x=1791294895; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/LI7Cx4rq7BtYr5e7cmDHzgqGSmRco6KSC9LU6lXIOw=;
        b=ZiKXRRP+SuH6t5tIABwsIwUGyNl5csjLyp7M4PG116XG55d0CRULBIBcK9VFsgS7/u
         7Lg2+w3G7DbOigEfba3Ub2v6PudU8zmp7W7nVm0/gy1xNZVfvOOPh9tGhUHBDMLBt1iF
         2qkjZbOtTStz0e7O+jdMZj/e+tP13mG0y3/gkzwPchLIES2XOeqhoygEBhFcLyCnrvOR
         5M03bLsu0K5csgYZGH0bbc8ZfB52sywUTMtKEoiKUen/v7l2DHJlng5Td4dzzEEqlVhE
         +A22mpJOz+KULnQFz+uLmKTlajgiYbbkWhRrfncSZFLkAZaLaF9ImeOt6IYD7jZK19Hn
         RRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790690095; x=1791294895;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/LI7Cx4rq7BtYr5e7cmDHzgqGSmRco6KSC9LU6lXIOw=;
        b=WCcCHjqnGDwqgNrnG5xJkPNeprX2MAtTmz4lEDmT91zsHli31x6gkVbjb/Xvj9NLst
         lBNUU7zY2+M6EMYb8wF7NvaZ9lpKIy+68Ow7rTAmwfhiYH2uDzBGq9NWzPkmL2fTVVqa
         pHVdqwzDFAftHw0mMPQMVNiVrRm1UnMpN4vyvZjG9VRmWEVDl+zmIzJuMc79Ru/bjKQf
         3KIFNvv3ng0UB7D9qHlgTk5zAUFj8tCBw34Ft6kOHfF/BuoVW01wCiVEGKdd+2hrk0j/
         Sy91L7DUkqN6H5RfIO3Hx8OhrhfV1LUGkM9X5K26eej/sV/juDdllEHN/AyeH8JhJcM3
         zTCQ==
X-Gm-Message-State: AFq9FYL+5S8n6F+EXrD5kTVtFIrjD5t/O13sxwblwympcM1EPHzWiV6b
	QsMJ7tStqnae5fu6pG/XSLyc/jGTcn20/5Qi/SyaDu+OFs6CffdzvPJ2woFhJuoKw+C/RZsrnNZ
	LfFmkGW1V/3c8lT99JiJ1H/Pt7b7R6qJAThBO
X-Gm-Gg: AYBFou3xF1Bxptq+T2ezxXGNOLgVrFn3CBbk/Vy0Cr0h5BEZcGk0B/VctHmezf31Ujp
	6Vz/Xo51pnCi/R3rwp2j29V12ShcHtRr4Im0OsTCO6WTRHvgjDejY5U1HnCxbwTOWa6rO3+bwLW
	fPdWPHtLMEkaMFjwkfmQkWUazaL63P3DusIZwnM4tOfQ81xtgC7rNJ6Zxt4lJcjKLhyxpLgjue+
	5L0JMOKqTtjjfHjkwmJK04mRqExeEwr8bgZMW7cP3AJ4R3YccpsHsaEeC99u1TjRiujoH11Lmc5
	PHJCjmDk7Rkfjx8BgShvEZHFWsxpEnODl4N+Kb228u0qbPAyOIqR4dkY
X-Received: by 2002:a05:6402:2347:b0:6a7:f25b:d281 with SMTP id
 4fb4d7f45d1cf-6aac8f404ecmr13225963a12.13.1790690093743; Tue, 29 Sep 2026
 06:54:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAiJnjo1JJAJ_Cu0FEZ5kxRaEEt9yqyGrJJq8ottwg=bNFo3rQ@mail.gmail.com>
 <20260929092534.44636-1-sj@kernel.org>
In-Reply-To: <20260929092534.44636-1-sj@kernel.org>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Tue, 29 Sep 2026 16:54:41 +0300
X-Gm-Features: AclHuK9byg2fXAETUQ2bQmyHZfQDDpRPE1xOLvsa4fMgIHcyluPjLBJM4uld-JI
Message-ID: <CAAiJnjrSKe9r7KXnWzrgb1-CRO0sDu7B_jK2mZDg7fPaT0Jdcg@mail.gmail.com>
Subject: Re: Memory tiering with DAMON/DAMOS auto-tuning
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Also, fyi again, from damo v3.4.1, you can mark start of new kdamond, con=
text,
> target and scheme parameters on the command line using --kdamond, --damon=
_ctx,
> --damon_target, and --damos_scheme.  you coud use those instead of
> --damos_nr_quota_goals, --damos_nr_filters, --nr_targets, --nr_schemes an=
d
> --nr_ctxs.  E.g.,

Fedora shows old damo version,

[root@localhost anton]# rpm -qa|grep -i damo
damo-3.3.0-1.fc44.noarch
[root@localhost anton]#

so I configured latest available 3.4.1

[root@localhost damo]# damo version
3.4.1
[root@localhost damo]# which damo
/home/anton/damo/damo
[root@localhost damo]#

> Seems you manually made this change.  Has this executed after 'damo start=
'?
> Also, did you 'commit' the updated commit input?  If any of your answer t=
o the
> questions is not "yes", the tuner update may not applied.

Yes, it was executed before 'damo start', but I didn't do 'commit'.

> It would also be helpful if you could run 'damo report damon --damos_stat=
s'
> periodically (say, once per 5-10 seconds) while the migration is ongoing =
and
> share the outputs with us.

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

[root@localhost ~]# /home/anton/damo/damo start \
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
sysinfo loading fail (info update fail (sysfs feature check fail
(feature map making fail (staging damos goal feature check purpose
kdamond failed))))
[root@localhost ~]#
[root@localhost ~]# ps -ef|grep -i damo
root       26051   25396  0 16:49 pts/2    00:00:00 grep --color=3Dauto -i =
damo
[root@localhost ~]#

> It would also be helpful if you could run 'damo report damon --damos_stat=
s'
> periodically (say, once per 5-10 seconds) while the migration is ongoing =
and
> share the outputs with us.

Sure, I will start something like that,
while true; do damo report damon --damos_stats >>
/home/anton/damo_report_damon_damos_stats; sleep 10; done
once damo will be started.


> Interesting.  I doubt if the tuner change is correctly made.  'damo repor=
t
> damon' can help us understand under what configuration DAMON is running. =
 It
> could help us quickly see if the configuration is done as we intended.  C=
ould
> you share 'damo report damon' result on the final state?

There are errors above during damo start.

Anton

=D0=B2=D1=82, 29 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 12:2=
5, SJ Park <sj@kernel.org>:
>
> On Tue, 29 Sep 2026 11:41:15 +0300 Anton Gavriliuk <antosha20xx@gmail.com=
> wrote:
>
> > Hello
> >
> > I decided to move step-by-step, so firstly I would get on Linux/bare
> > metal or non-VmWare setup memory tiering behaviour like on VmWare 9.1
> > - https://knowledge.broadcom.com/external/article/449016/understanding-=
nvme-memory-tiering-activa.html#:~:text=3DCause.%20This%20behavior%20is%20b=
y%20design.%20The,page%20activity%20based%20on%20recency%20and%20frequency.
> >
> > "Threshold Activation: The VMkernel initiates memory tiering only when
> > total host physical DRAM (Tier 0) consumption reaches approximately
> > the 80% threshold. If consumption is below this trigger (e.g., at
> > 70-75%), the system will not migrate pages to Tier 1.
> > Page Classification: ESXi monitors page activity based on recency and
> > frequency. Only memory pages strictly classified as "cold" (inactive)
> > are migrated to the NVMe Tier 1 device. The active working set ("hot"
> > pages) is deliberately retained in Tier 0 to prevent performance
> > penalties.
> > Scan Rate: The page scan and migration rate scale with memory
> > pressure. At lower consumption levels (just crossing the 80% mark),
> > the rate is highly conservative."
>
> Sounds good.
>
> >
> > Here is my corrected command,
> >
> > damo start \--numa_node 0 --monitoring_intervals_goal 5% 3 5ms 10s
>
> Fyi, '--monitoring_intervals_autotune' is same to
> '--monitoring_intervals_goal 4% 3 5ms 10s'.
>
> > \--damos_action migrate_cold 2 --damos_access_rate 0% 0%
> > \--damos_apply_interval 1s \--damos_quota_interval 1s
> > --damos_quota_space 8GB \--damos_quota_goal node_mem_free_bp 50% 0
> > \--damos_filter reject young \--numa_node 2
> > --monitoring_intervals_goal 5% 3 5ms 10s \--damos_action migrate_hot 0
> > --damos_access_rate 5% max \--damos_apply_interval 1s
> > \--damos_quota_interval 1s --damos_quota_space 8GB \--damos_quota_goal
> > node_mem_used_bp 50.3% 0 \--damos_filter allow young
> > \--damos_nr_quota_goals 1 1 --damos_nr_filters 1 1 \--nr_targets 1 1
> > --nr_schemes 1 1 --nr_ctxs 1 1
>
> Also, fyi again, from damo v3.4.1, you can mark start of new kdamond, con=
text,
> target and scheme parameters on the command line using --kdamond, --damon=
_ctx,
> --damon_target, and --damos_scheme.  you coud use those instead of
> --damos_nr_quota_goals, --damos_nr_filters, --nr_targets, --nr_schemes an=
d
> --nr_ctxs.  E.g.,
>
> damo start \
>         ` # A kdamond to demote cold memory from node 0 to node 2 ` \
>         --kdamond --damon_ctx --monitoring_intervals_autotune \
>                 --damon_target --numa_node 0 \
>                 --damos_scheme \
>                         --damos_action migrate_cold 2 \
>                         --damos_access_rate 0% 0% --damos_apply_interval =
1s \
>                         ` # up to 8 GiB per second ` \
>                         --damos_quota_interval 1s --damos_quota_space 8G =
\
>                         ` # aiming at least 50% node 0 free memory ` \
>                         --damos_quota_goal node_mem_free_bp 50% 0 \
>                         --damos_filter reject young \
>         ` # A kdamond to promote hot memory from node 2 to node 0 ` \
>         --kdamond --damon_ctx --monitoring_intervals_autotune \
>                 --damon_target --numa_node 2 \
>                 --damos_scheme \
>                         --damos_action migrate_hot 0 \
>                         --damos_access_rate 5% max --damos_apply_interval=
 1s \
>                         ` # up to 8 GiB per second ` \
>                         --damos_quota_interval 1s --damos_quota_space 8G =
\
>                         ` # aiming at least 50.3% node 0 memory utilizati=
on ` \
>                         --damos_quota_goal node_mem_used_bp 50.3% 0 \
>                         --damos_filter allow young \
>
> >
> > with consist -> temporal,
> >
> > [root@localhost ~]# cat
> > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/schemes/0/quotas/goal_=
tuner
> > temporal
> > [root@localhost ~]# cat
> > /sys/kernel/mm/damon/admin/kdamonds/1/contexts/0/schemes/0/quotas/goal_=
tuner
> > temporal
>
> Seems you manually made this change.  Has this executed after 'damo start=
'?
> Also, did you 'commit' the updated commit input?  If any of your answer t=
o the
> questions is not "yes", the tuner update may not applied.
>
> You can specify what tuner to use on 'damo' command together, using
> '--damos_quota_goal_tuner' option.  I'd recommend using that.  E.g.,
>
> damo start \
>         ` # A kdamond to demote cold memory from node 0 to node 2 ` \
>         --kdamond --damon_ctx --monitoring_intervals_autotune \
>                 --damon_target --numa_node 0 \
>                 --damos_scheme \
>                         --damos_action migrate_cold 2 \
>                         --damos_access_rate 0% 0% --damos_apply_interval =
1s \
>                         ` # up to 8 GiB per second ` \
>                         --damos_quota_interval 1s --damos_quota_space 8G =
\
>                         ` # aiming at least 50% node 0 free memory ` \
>                         --damos_quota_goal node_mem_free_bp 50% 0 \
>                         ` # using temporal tuner ` \
>                         --damos_quota_goal_tuner temporal \
>                         --damos_filter reject young \
>         ` # A kdamond to promote hot memory from node 2 to node 0 ` \
>         --kdamond --damon_ctx --monitoring_intervals_autotune \
>                 --damon_target --numa_node 2 \
>                 --damos_scheme \
>                         --damos_action migrate_hot 0 \
>                         --damos_access_rate 5% max --damos_apply_interval=
 1s \
>                         ` # up to 8 GiB per second ` \
>                         --damos_quota_interval 1s --damos_quota_space 8G =
\
>                         ` # aiming at least 50.3% node 0 memory utilizati=
on ` \
>                         --damos_quota_goal node_mem_used_bp 50.3% 0 \
>                         ` # using temporal tuner ` \
>                         --damos_quota_goal_tuner temporal \
>                         --damos_filter allow young \
>
> >
> > But it again didn't stop ~50%
> >
> > [root@localhost ~]# numastat -p $(pgrep valkey-server)
> >
> > Per-node process memory usage (in MBs) for PID 18036 (valkey-server)
> >                            Node 0          Node 1          Node 2
> >                   --------------- --------------- ---------------
> > Huge                         0.00            0.00            0.00
> > Heap                         0.11            0.00            0.00
> > Stack                        0.03            0.00            0.00
> > Private                 228807.54            0.48          185.79
> > ----------------  --------------- --------------- ---------------
> > Total                   228807.67            0.48          185.79
> >
> >                            Node 3           Total
> >                   --------------- ---------------
> > Huge                         0.00            0.00
> > Heap                         0.00            0.11
> > Stack                        0.00            0.03
> > Private                      0.00       228993.80
> > ----------------  --------------- ---------------
> > Total                        0.00       228993.94
> >
> >
> > [root@localhost ~]# numastat -p $(pgrep valkey-server)
> >
> > Per-node process memory usage (in MBs) for PID 18036 (valkey-server)
> >                            Node 0          Node 1          Node 2
> >                   --------------- --------------- ---------------
> > Huge                         0.00            0.00            0.00
> > Heap                         0.01            0.00            0.10
> > Stack                        0.01            0.00            0.02
> > Private                  13434.01            0.48       215559.31
> > ----------------  --------------- --------------- ---------------
> > Total                    13434.03            0.48       215559.43
> >
> >                            Node 3           Total
> >                   --------------- ---------------
> > Huge                         0.00            0.00
> > Heap                         0.00            0.11
> > Stack                        0.00            0.03
> > Private                      0.00       228993.80
> > ----------------  --------------- ---------------
> > Total                        0.00       228993.94
>
> Interesting.  I doubt if the tuner change is correctly made.  'damo repor=
t
> damon' can help us understand under what configuration DAMON is running. =
 It
> could help us quickly see if the configuration is done as we intended.  C=
ould
> you share 'damo report damon' result on the final state?
>
> It would also be helpful if you could run 'damo report damon --damos_stat=
s'
> periodically (say, once per 5-10 seconds) while the migration is ongoing =
and
> share the outputs with us.
>
> >
> >
> >
> > > > Oohhh... I moved to 5%.
> > > I understand you mean 4%?
> >
> > As far as I understood, this value represents "accuracy", so there
> > shouldn't be a big difference between 4% vs 5%.  Or please correct me
> > if I'm wrong.
>
> Yes, 5% vs 4% should be an ignorable small difference.
>
>
> Thanks,
> SJ
>
> [...]
