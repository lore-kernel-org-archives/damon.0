Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CAE19C556
	for <damon@lists.linux.dev>; Thu, 23 Apr 2026 00:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776904999; cv=none; b=GLzzsXWlm4Hrfu5H7xctMa7Wqzb3RPf2S3wmV3cdisDhmwv8d9Vo8XHZ8fIDBmzXS8QjZuLAaZhGHTqbBIM3ARfXwBaFwfT7I93AxWZNvbk0L3SZ8+CAE+QLldNHtsU3tzzWLC7EJ142Z/bVWUqNOYeBglyVWyeqbTLC56muva0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776904999; c=relaxed/simple;
	bh=03/Nz7I9y/2C2L6mQIhV/CFh40AiCHKK+NtUEn+FO2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cm4ytykzxsGGO9fA+b3+GDmC2ouPNJYRjeKDX+B8tUybOnap698hYks8TII2hZaZBxtPAmw4Q4nxEXqQgZqI8i667fpAmVL6VIia9YwNk4eKtiSnjKzOUszoFCv489TGpH94G60ahQz8mvagdHhXQwXYOVYUvbie95GIfcdlw2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpM6uEcT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpM6uEcT"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a871daa98fso40120355ad.1
        for <damon@lists.linux.dev>; Wed, 22 Apr 2026 17:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776904997; x=1777509797; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+tG2Z5j0bG2Jz4vsU5nysQGQqcBOT5VAsxoLEyOLy5w=;
        b=SpM6uEcT4jd38xRcPPWErbHbEn5+ErYS9wGoZ0/hmGzTdBj0a8v89C4Pt66kvKN5Vr
         ryqVmL2tJ4O7keu5JwYOrPRga994nxL1vxjUtu4gG//j+9fjQT8+ZsnwF9D4zPwjmvfQ
         LYMU2y1u9h9l8R7la+eW9ySi4U2wFO1DExFTZ0zP0vOBBuqXzyawYRAWkQMKHlOSzPd2
         Dd5wRT3rvWLEgt/U/I67RI/9iQ42m4/GYF3lItK5ICCxxg6LuaA1cMBJgd/3hDLBySbG
         wzjx8BsUH4rDRnumarpEyF23x/AVJPggMKDyp9c4MyroWb+3+jlItMZJDo+zasmze/fz
         x7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776904997; x=1777509797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tG2Z5j0bG2Jz4vsU5nysQGQqcBOT5VAsxoLEyOLy5w=;
        b=Kqe0wEYaE9IZl6sWMiaFSx3aDRGkyjG+nKFfIz0UOpXQ42imqHZ3K2s1FKIq9ZCibk
         JZWG2gro1wJKZ3S1ME3YAURctvbhHPrGJjkiW/MLeLVFjDcvsRvlrFVGP5+jDa9hdAAW
         qZySFTHK2jz9doa7l9PVVi2ST8W+uursRkFrp+OUabgWfnUIDVA+zzNEpwOD7qVkkY9b
         AqJu04kMDShO4xCTDPTvv7FE+FRli3DEL4mABjYaw5dX7K9l4BdMEJ8FSsfDlto0ciXB
         IzzbJHTGxBKH31EbKUiflvzBRSE2/Uvab2MC4DuN7sqXEvFROp447ePSsT2QReNUPYh/
         3KzQ==
X-Gm-Message-State: AOJu0YwZHIomDfTOtaHoUMmmO+hi0WPALfMCwpV0o+5pYbnGnLXaSsHx
	9XrVkLza7TOxbPs0pD1RH73DXpo34thMcOYUtzs8qoniIVSDbefg7rSq7h374Q==
X-Gm-Gg: AeBDievY6y0tS2a7aDdkww9FAkXp41MIBAgNH4r3E/EvsdfwOVhWdcJEt4hKTNpL2Tb
	sTcaAxnjrVMahQEPKqcjSZBmrSHRDRSTIciHrwXFKNY179oKzTNBz/h2wHSV94e8lwruI0NsCfV
	kI8604/VSN7Xd1MhRH250ubLgp03XDUc1txTI0cLg/szpX+zPH+fz7A0sa3M0TDbdbxjWXURz2k
	VuAvTqwKBQX0t8sAhMoLYdCGwgF08Shxmw1rWHOmkjxGtj4anys9d8IWrMjfKKzeJP+ty/wK0YU
	7gQGA+2Qg4XCEv0vB3aVdufN5XGNsF2jMVQISNOa+V89HjRh4HWBM2mRxCIP1mmUuXnh52+WlBp
	RzWoBIdNHQwMb6Vp83EqfOhES2M48eAgoOMVIGnrCNVHfD4vil4Gg9uMRT1YRJ4h5gZ0BSm/rhr
	ypv5RwCuc+ggTr/Cg9wgiTv44ZeatnS9sfJzM6Bry/3jkAdJng
X-Received: by 2002:a17:903:38c4:b0:2b4:5f69:715d with SMTP id d9443c01a7336-2b5f9f36ea9mr296776365ad.25.1776904997329;
        Wed, 22 Apr 2026 17:43:17 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:963d:c5da:6762:8843])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab4bf7bsm176724085ad.81.2026.04.22.17.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 17:43:16 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org,
	sj@kernel.org,
	akinobu.mita@gmail.com
Subject: [RFC PATCH v3 0/4] mm/damon: introduce perf event based access check
Date: Thu, 23 Apr 2026 09:42:06 +0900
Message-ID: <20260423004211.7037-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON currently only provides PTE accessed-bit based access check, this
patch series adds a new perf event based access check.

Since perf event-based access checks do not require modifying the PTE
accessed-bit for pages representing each damon region, it reduces the
overhead of monitoring at a fixed granularity of the page size.

Here is a method and its results for comparing access checks using
existing access bits and new perf events.

The time required for the access check will be measured using the
following steps.

Start a memcached server with approximately 100GB of memory and run a
benchmark client.
```
# Run memcached as a daemon
memcached --daemon --pidfile=/tmp/memcached.pid --port=7777 \
  --memory-limit=200000 --threads=8
# Load keys
memtier_benchmark -s 127.0.0.1 -p 7777 --key-maximum=100000000 \
  --data-size=1000 --threads=8 --protocol=memcache_text \
  --key-pattern=P:P --ratio=1:0 --requests=allkeys
# Run benchmark in the background
memtier_benchmark -s 127.0.0.1 -p 7777 --key-maximum=100000000 \
  --data-size=1000 --threads=8 --protocol=memcache_text \
  --key-pattern=Z:Z --ratio=50:50 --test-time=999999 --pipeline=10 \
  --distinct-client-seed --randomize &> /tmp/memtier.log &
```

Measure the time required for access checks when monitoring memcached at
page size granularity.

Using accessed bit, prepare_access_checks takes 7 seconds and
check_accesses takes 5 seconds.
```
$ sudo $HOME/damo/damo start --ops vaddr \
	--monitoring_intervals 5s 60s 300s \
	--monitoring_nr_regions_range 1000000000 1000000000 \
	--target_pid $(cat /tmp/memcached.pid)
$ sudo perf ftrace latency -a --hide-empty \
  -T damon_va_prepare_access_checks -- sleep 60
#   DURATION     |      COUNT | GRAPH                                          |
     1 - ...  s  |          4 | ############################################## |

# statistics  (in usec)
  total time:             28624961
    avg time:              7156240
    max time:              7322209
    min time:              6859464
       count:                    4
$ sudo perf ftrace latency -a --hide-empty \
  -T damon_va_check_accesses -- sleep 60
#   DURATION     |      COUNT | GRAPH                                          |
     1 - ...  s  |          3 | ############################################## |

# statistics  (in usec)
  total time:             16007973
    avg time:              5335991
    max time:              5369579
    min time:              5300285
       count:                    3
```

Using perf event, prepare_access_checks takes 0.01 seconds and
check_accesses takes 2.6 seconds.
```
$ sudo $HOME/damo/damo stop
$ sudo $HOME/damo/damo start --ops vaddr \
	--perf_event 5000 0 0x4 0x1cd 0x1f 0 \
	--monitoring_intervals 5s 60s 300s \
	--monitoring_nr_regions_range 1000000000 1000000000 \
	--target_pid $(cat /tmp/memcached.pid)
$ sudo perf ftrace latency -a --hide-empty \
  -T kdamond_prepare_perf_event_report -- sleep 60
#   DURATION     |      COUNT | GRAPH                                          |
     4 -    8 ms |          7 | ############################################## |

# statistics  (in usec)
  total time:                75641
    avg time:                10806
    max time:                11174
    min time:                 9945
       count:                    7
$ sudo perf ftrace latency -a --hide-empty \
  -T kdamond_check_perf_event_reported_accesses -- sleep 60
#   DURATION     |      COUNT | GRAPH                                          |
     1 - ...  s  |          7 | ############################################## |

# statistics  (in usec)
  total time:             18101248
    avg time:              2585893
    max time:              2834578
    min time:              2504466
       count:                    7
$ kill $(cat /tmp/memcached.pid)
```

The time required for prepare_access_checks is proportional to the size of
the monitoring region when using the accessed bit, but it takes almost no
time when using the perf event as it only requires enabling it.

The time required for check_accesses is proportional to the size of the
monitoring region, regardless of whether you use the accessed bit or
perf-event.

This indicates that monitoring even larger memory ranges at page
granularity could take even longer.

However, when using perf-event, there is room in the future to make the
time proportional to the number of perf event samples by changing the
monitoring region management from an address-order linear list to a tree
structure.

It is important to note that with perf events, extra memory such as
sampling buffers needs to be allocated, and there is overhead due to perf
event interrupts (NMI) during the sampling interval.

Note: damo's --perf_event option

Using these features also requires modifications to damo, but these
are not included in this patch series and are currently under
development in the following branch:

* https://github.com/mita/damo/tree/damo-perf-for-v3.2.2

The option newly added to damo for perf event-based access check has the
following format:

`--perf_event <sample freq> <sample phys addr> <type> <config> <config1> <config2>`

- `sample freq`: A higher frequency improves access accuracy, but also
  increases overhead.
- `sample phys addr`: specify 0 for vaddr and 1 for paddr.
- The remaining type, config, config1, and config2 settings can be found
  as follows:

Run `perf mem record -vv` to obtain the log, and then find the part in
the log where `perf_event_open` was executed successfully.
```
$ sudo perf mem record -vv echo > /tmp/perf-mem-record.log 2>&1
$ cat /tmp/perf-mem-record.log
...
perf_event_attr:
  type                             4 (cpu)
  size                             144
  config                           0x1cd (mem_trans_retired.load_latency_gt_1024)
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|ADDR|ID|PERIOD|DATA_SRC|WEIGHT_STRUCT
  read_format                      ID|LOST
  disabled                         1
  inherit                          1
  mmap                             1
  comm                             1
  freq                             1
  enable_on_exec                   1
  task                             1
  precise_ip                       2
  mmap_data                        1
  sample_id_all                    1
  mmap2                            1
  comm_exec                        1
  ksymbol                          1
  bpf_event                        1
  build_id                         1
  { bp_addr, config1 }             0x1f
------------------------------------------------------------
sys_perf_event_open: pid 287986  cpu 0  group_fd -1  flags 0x8 = 5
...
```

The values for `type` and `config` are taken from this output.
Use the values of `config1` and `config2` if they are included in the log;
otherwise, set them to 0.

Any feedback or advice on the patch set would be greatly appreciated.

* RFC v3
- drop "reintroduce damon_operations->cleanup()" as no longer needed
- drop "allow user to set min size of region" (will be sent separately)
- add tgid to struct damon_access_report and use it instead of tid
- set perf_event_attr.precise_ip to 2
- prepare for the transition to report-based monitoring
- switch to use access_reported in struct damon_region
- switch to use sample/primitives/perf_events sysfs directory

* RFC v2: https://lore.kernel.org/damon/20260309010009.11639-1-akinobu.mita@gmail.com/T/
- reintroduce damon_operations->cleanup()
- introduce struct damon_access_report
- use struct damon_access_report instead of introducing struct
  damon_perf_record
- remove maximum region size setting

* RFC v1: https://lore.kernel.org/damon/20260123021014.26915-1-akinobu.mita@gmail.com/T/

* TODO
- Integrate into report-based monitoring
- Explain actual usage examples and test results
- Send the necessary patches to damo
- Set maybe_corrupted when it detects that a useless perf_event has
  been specified.
- Check if it works in a virtual environment using vPMU

Akinobu Mita (4):
  mm/damon/core: add code borrowed from report-based monitoring work
  mm/damon/core: add common code for perf event based access check
  mm/damon/vaddr: support perf event based access check
  mm/damon/paddr: support perf event based access check

 .../ABI/testing/sysfs-kernel-mm-damon         |   8 +
 include/linux/damon.h                         | 102 ++
 mm/damon/core.c                               | 113 ++-
 mm/damon/ops-common.h                         |  59 ++
 mm/damon/paddr.c                              |  41 +
 mm/damon/sysfs.c                              | 872 +++++++++++++++++-
 mm/damon/vaddr.c                              | 506 ++++++++++
 7 files changed, 1697 insertions(+), 4 deletions(-)

-- 
2.43.0

