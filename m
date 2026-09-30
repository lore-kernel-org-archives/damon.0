Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EEB511180
	for <damon@lists.linux.dev>; Wed, 30 Sep 2026 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790785615; cv=pass; b=Gy9dcA4A+sEUXWjWp7qdEM0pLl4sO2Pl2+fidqORb782VhxD0zPqImUQCs6Vr4705zZ5zk6LutH9nVRQ/OvtXNTvDJ5USf3eO3f/GLTa7rtaZGXCZ8HiBwUBF6m+Abg6F7rcumul4b4VmWouoQWPjvh345Z4Oc2WVz8Mu4EVHN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790785615; c=relaxed/simple;
	bh=iXh6PW4CsEA7ut5UsvBrM6BlYv+oOpLj0NvON21bo2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrzoyRr0RH6UWhLk2+aN+05oi56MFV3AkI3B9ByOVLyaUs8rkUwRbSdnN1Cken0iFVRV61Pg56LKFqEcn1KPoT1njm2Lu3/nY6pgEpSV0UlV/QWOlyCx98jbukJjtmBBYToKhiR5U1giwi5BEybEJhykSi0YDuQ+3Zw9UcKP9Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuJGJoIw; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuJGJoIw"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acac47206aso3256465a12.1
        for <damon@lists.linux.dev>; Wed, 30 Sep 2026 09:26:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790785603; cv=none;
        d=google.com; s=arc-20260327;
        b=fkC3AiCzHYC/ry5cWOTwMdnfWavPNOhf1SobH6R+AWFh1V1bnFT6aAE7FLW9H+Qlns
         VyWI5xuvoXMDwWWvGrvLUXluKWtUfUwwhbi9CTtNqAz9ZfEdGrEC3QQlBkw6X0BDFBO4
         rcLap3Y2pql00XtfWkuAqDqtgFCyFvFi5p7js6akbAI227ymJV3r6XOfU0s+yicd1v01
         lAWeMj/JPVhDmI6AdOQWNGqGGD1SyhIse0F0HxXrO3/M2yScTC7X2YcP9U4M5ZBBAvS9
         Bsdepbv7WEhD70eZ3IiWISP413l9nSWmY3Xln/fF4mh2o66mcPOZxeVp4jjS3KNSjlMI
         YAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QBDH10ijgxx37uF1q/nX4lq/8Yq5lBqCkkNGqSrZAdQ=;
        fh=e+kRStJq+twn6rlp7glLc6kIxtYd+ofNVnbBqiY9oQA=;
        b=qNyt3RK5+oRbJVPMUhscYAHJAhuv6bn1YNjnoVZkK8KEEk+PhKP//Nm8oP6ggvJr1E
         tpTs2KcMTeZpD33VHqhAFdeW3189unp9IJ0WwxZejkxZbBckAImHK9Sk64GtXJdlMFxI
         Gv7rtWA/O9EpMVcK0Rc15NRD6lvJ923hJgjDHk1VEJ2zUjHIEwYAT8fGFieP9OxF9lbh
         on+2ycHV4DxfA5xth2zw1o4xzJ8CCVGKJ3PeKWriLmw4aiR0EM7BveXPO9hirbwoMw+M
         eunmKAXPkVIqmF+1byOIMzhX2NGtTuIv6ZOcxrnrJki1eE6oHOQVk3puQRNrq2wm+y7V
         HBXg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790785603; x=1791390403; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QBDH10ijgxx37uF1q/nX4lq/8Yq5lBqCkkNGqSrZAdQ=;
        b=EuJGJoIwpdzBj0LDTrbJVmkFt5RcTBOMoYvsEDwnOJv0uGl2JKN5BYUo0DCPXmGysJ
         IjHymxZI0kztR57E3tG8w1tTeWBlMgMMCl5cGHRE8yd5rBhKNewfio5g4oUrLouhfi0P
         hb+o5A1TlT5UtQ2oxAn/rX9MGUGaxmAVm0oHrhYYlU5vPMhJGpAqaJip2+cuRyr1+UQL
         0RLUgOWMWKYXZ4+Gqy5uotAXTEGRLo+uXFkbUBcg7jMZEwDbveUiUTe4+vFeIM4e35fA
         I2YSpu8sddRA2yc294bSjkhhR0ZeFj95lwdJhb6ILAHEZB2wVR8QKz7/zO93pIFvhGdX
         7nBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790785603; x=1791390403;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QBDH10ijgxx37uF1q/nX4lq/8Yq5lBqCkkNGqSrZAdQ=;
        b=xA+1u6VzWYxKSTYaBsmdnK8b1BkaeGA2MhUL0O5iw+XF7yHuKEbVq3nFygULB/AYm6
         ulnCpvHGrVEMT2JDKqWiz62prOD6wgNlRcqZ7U/FpY34695J87OTl9d4rJz6qlaVc3eo
         4FJxiQIQ6iCuhMSkSATYGXT4uvNPhguQZ4cJgmRY7PdnJY9XuFOuzgJKhCVDJwY67KK7
         6rEQJrhrpYFfjltwvMK5bhcQRqtehqkTXg53kYJJnEAlc0wMtcbzaT9VQMUwVCFuZ8X6
         uIG2V8mFJa2hWKUGaTNh440xUQDTa1pcKzLTyUkBXEcE6JmMobqZEL9Gnwm6RNPGGdk/
         H6pA==
X-Gm-Message-State: AFq9FYK1shKtVCkgMiW8AOy/Pihx6mhtI2E5f2/WOkQKnRKCPoNWlUqU
	6RN9GPkmtIWuO+EBhlkQYP8XCDRohhPnTwfzEM7hqxzopKeL4ne4CZMjHHFJf4zlgs0TnchxVnK
	fnytCsLd5cfLfbF6INg0xFvyLeZsnnbtHA6tQ
X-Gm-Gg: AYBFou1tRiwjPNqbO6I6urud/K5H/YbEo1V1udOwvV9ScWV12CZx5Sleo3rxCJo/tO3
	wpkRXmC0ZUrZKZ/aGqn7J68fvsNEpDwF57F4nJTJ2QVJ8L3yI2kFl2Yv5c6j5QTkwsA6ILE+45c
	oaFNXlXgT0laeV1oZsm/Qf/2nE++0kJYRmp7pzwvFXN0PpCBQeRvAAyyvWpy040JlzN7SKXVYfx
	N0PmCp/CDXgFqK+c/g2EO+RnEvtEISMdE4hJqvQ6sUGYN8tSZgnLdTiU8RpntapEmshsUgwBdDO
	KLfkq315kfrJ8ycA13lnj1iiwl7A70kMq+iZswSIK/hFwyR+d3VVvc7r
X-Received: by 2002:a05:6402:21db:b0:6ac:6b18:344e with SMTP id
 4fb4d7f45d1cf-6ae19864a04mr1318387a12.2.1790785602710; Wed, 30 Sep 2026
 09:26:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAiJnjq_XJ+kvNFdbXNJUrJMVtj5BVqN+NoZ2PvxYavFjOg2fw@mail.gmail.com>
 <20260930083552.11289-1-sj@kernel.org>
In-Reply-To: <20260930083552.11289-1-sj@kernel.org>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Wed, 30 Sep 2026 19:26:31 +0300
X-Gm-Features: AclHuK9v_2C_STquKkivKCPatCukMGfjHv3w3UQIA7Hme-xYlEBTwcgOamvCpQY
Message-ID: <CAAiJnjoaaPk3CcczDtk72xfkrgwp29KDT1==PZJJGgUcBVpdjA@mail.gmail.com>
Subject: Re: Memory tiering with DAMON/DAMOS auto-tuning
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I would go back to memory tiering VCF9.1-like behavior you helped me
configure, for new few questions:

1.  It works with the goal of 50% free memory for numa node 0, but
when I tried to set 25% free memory, it didn't do anything...

[root@localhost ~]# COLUMNS=3D500 numastat -p $(pgrep valkey-server) | cat

Per-node process memory usage (in MBs) for PID 3808 (valkey-server)
                           Node 0          Node 1          Node 2
    Node 3           Total
                  --------------- --------------- ---------------
--------------- ---------------
Huge                         0.00            0.00            0.00
      0.00            0.00
Heap                         0.11            0.00            0.00
      0.00            0.11
Stack                        0.03            0.00            0.00
      0.00            0.03
Private                 238356.25            2.19            3.42
      0.00       238361.86
----------------  --------------- --------------- ---------------
--------------- ---------------
Total                   238356.39            2.19            3.42
      0.00       238362.00
[root@localhost ~]#


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
                        ` # aiming at least 25% node 0 free memory ` \
                        --damos_quota_goal node_mem_free_bp 25% 0 \
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
                        ` # aiming at least 75.3% node 0 memory utilization=
 ` \
                        --damos_quota_goal node_mem_used_bp 75.3% 0 \
                        ` # using temporal tuner ` \
                        --damos_quota_goal_tuner temporal \
                        --damos_filter allow young \


[root@localhost ~]# cat
/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/schemes/0/quotas/goal_tune=
r
temporal
[root@localhost ~]# cat
/sys/kernel/mm/damon/admin/kdamonds/1/contexts/0/schemes/0/quotas/goal_tune=
r
temporal


[root@localhost ~]# COLUMNS=3D500 numastat -p $(pgrep valkey-server) | cat

Per-node process memory usage (in MBs) for PID 3808 (valkey-server)
                           Node 0          Node 1          Node 2
    Node 3           Total
                  --------------- --------------- ---------------
--------------- ---------------
Huge                         0.00            0.00            0.00
      0.00            0.00
Heap                         0.11            0.00            0.00
      0.00            0.11
Stack                        0.03            0.00            0.00
      0.00            0.03
Private                 238356.25            2.19            3.42
      0.00       238361.86
----------------  --------------- --------------- ---------------
--------------- ---------------
Total                   238356.39            2.19            3.42
      0.00       238362.00
[root@localhost ~]#


2. If there are no un-accessed pages to demote for achieving a defined
goal, damon will demote pages with the most rare access ?

Anton

=D1=81=D1=80, 30 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 11:3=
5, SJ Park <sj@kernel.org>:
>
> On Wed, 30 Sep 2026 07:03:47 +0300 Anton Gavriliuk <antosha20xx@gmail.com=
> wrote:
>
> > > Oops...  Seems you were running next branch of damo.  There was a bug=
.  I
> > > reproduced it on 7.2.8 kernel, and fixed it.  The fix [1] is now push=
ed.  Could
> > > you pull the 'next' branch and try again?
> >
> > Done.
> [...]
> > It looks now it keeps ~50% free numa node 0,
>
> Awesome :D
>
> [...]
> > [root@localhost ~]# /home/anton/damo/damo report damon
> > kdamond 0
> >     state: on, pid: 29836
> >     context 0
> >         ops: paddr
> [...]
> >         scheme 0
> >             action: migrate_cold to node 2 per 1 s
> >             target access pattern
> >                 sz: [0 B, max]
> >                 nr_accesses: [0 samples, 0 samples]
> >                 age: [0 aggr_intervals, 184,467,440,737,095 aggr_interv=
als]
> >             quotas
> >                 0 ns / 8.000 GiB / 0 B per 1 s
> >                 goal 0: metric node_mem_free_bp (nid 0) target 5,000 cu=
rrent 0
> >                 goal tuner: temporal
>
> Ok, the above line confirms DAMON is running with 'temporal' tuner.
>
> [...]
> > DAMON & DAMOS are very flexible, so it requires a deep understanding
> > of specific workload and how to configure memory tiering with DAMON &
> > DAMOS.
>
> Indeed it is.  Nonetheless, for the reason we provide DAMON modules [1] o=
r damo
> scripts for commonly known DAMON usages.  We have DAMON_RECLAIM module [2=
] for
> proactive memory reclamation, and mem_tier.sh [3] for memory tiering.
>
> My suggestion is to start from such examples, find what is not working an=
d
> asking questions to me.  So you are doing all great :D
>
> >
> > So firstly I decided to make it like VMware VCF 9.1 does :-)), next I
> > will reduce the goal from 50% free to 25-25% for numa node 0.
>
> Sounds like a good plan.
>
> >
> > Based on the outputs above, please let me know if other improvements
> > are required.
>
> This temporal tuner test has proved the quota system is not broken.  It i=
mplies
> the previous test resulted in migrating nearly all data to the lower tier=
,
> because there was no hot data to promote back to the upper tier.
>
> In many common benchmarks using zipfian-like access distribution, hot dat=
a is
> always hot, and cold data is always cold.  And usually the amount of cold=
 data
> is much larger than hot data.  I found [4] the pattern is making evaluati=
on of
> tiering solutions difficult, and was using artificial access pattern mixi=
ng to
> work around.
>
> My imagined real world workload is, there will be hot and cold data.  And=
 the
> pattern will nearly always be stable.  But, occasionally there will be ch=
anges.
> Say, a chunk of data will be hot for a few hours, but suddenly be cold an=
d keep
> being cold for a few hours, then sudenly be warm for hours, and so on.  T=
he
> auto-tuning based DAMON tiering is designed with such workload in mind.
>
> For your testing, I think the setup is good.  I'd suggest lower target fr=
ee
> memory ratio, though.  Assuming the theory (your workload has static acce=
ss
> pattern of small hot data) is true, using consist tuner should also be fi=
ne.
>
> You will have more than expected data in lower tier, but if those are tru=
ly
> cold, why would we bother?  If you still want strict upper tier utilizati=
on,
> you could make the access pattern and filter condition less strict.  Idea=
lly,
> the access pattern and filter conditions should all go away, assuming DAM=
ON can
> find true hot and cold data.  And I believe that would be the case for
> long-running real world workloads.  Short-running test workload would sho=
w
> DAMON making wrong decisions in short term, though.
>
> If you want to make sure if my theory is true, you could also profile the
> access pattern of your test workload using DAMON.  I actually did it for =
my
> auto-tuned tiering test [4] to find the fact.
>
> [1] https://origin.kernel.org/doc/html/latest/mm/damon/design.html#specia=
l-purpose-access-aware-kernel-modules
> [2] https://origin.kernel.org/doc/html/latest/admin-guide/mm/damon/reclai=
m.html
> [3] https://github.com/damonitor/damo/blob/next/scripts/mem_tier.sh
> [4] https://lkml.kernel.org/r/20250420194030.75838-1-sj@kernel.org
>
>
> Thanks,
> SJ
>
> [...]
