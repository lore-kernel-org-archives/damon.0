Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D92EEAFD
	for <damon@lists.linux.dev>; Sat, 24 Jun 2023 23:27:12 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-39ca120c103so1502576b6e.2
        for <damon@lists.linux.dev>; Sat, 24 Jun 2023 16:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687649231; x=1690241231;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gNoXCMJZ7ZemvEfkjSUdyijV0Z3VXPJjXOSf1b+ViNA=;
        b=gAASgBKH/lMX5rysNdgpykl6+EooOFBBTvhA/t2Ndm2t7WfETBUgMZy6EUef0Ok/95
         ElnVT4co0Ca6wd3IKw4uy0EEegr0SSVdCLpOXVXIqbWg5xsJ9gOa1R+JZ11pTYReiw4O
         IaEN/rgqyLLiZctOnieIaQSY0ATTQMnojWqTkXdR7ZqrkPRPs0V5o7oDRNItpxff/ir9
         +yQ5KyC/cGCnUw+70wigKxM7Uw+MerZf5bJfZgJLExVw8k9rd65DyuHLNt9lhUg+BvYH
         t24IFl6DSGaf8s4i1cDqbtFnIJdPZLO7FDgoiF3DqyUy25GmlIoLPMN2aFcGQVTy2LWC
         Rrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687649231; x=1690241231;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gNoXCMJZ7ZemvEfkjSUdyijV0Z3VXPJjXOSf1b+ViNA=;
        b=DtcdUgPaR9aygHdH5DnHA/MdUNA93VH3loqof+g2/WBrUIvZaIbOxLbIt58sDV/hZt
         KlYFlbcr80DAn0jKXRfwMY8TiEliNswvFsqE5/WL6k8Q3YG43AtJyCkys+75XvgW9mp/
         Qw5FXayfYK2EEjJ7TdoR5qqvwCyaKZYgGqsrK01bfcBdLuIK2DTvrYyijOE3KCakdhiL
         zamQkqfFxNo6Y5jY4PmMHC1AgK08hv5KZkzeN07zCzoL6RagSq0Nlwm9QjGxEaSD/4EA
         VSrVuCvdWCqIt7FeRQk4zOAMJEKmfLJgjzRRjdpytJbMCrsLaMKkfRwfPOT/p3YgBfy1
         CJxQ==
X-Gm-Message-State: AC+VfDyLW+X5N204bD1939JLOYqhZINnIflW8QiQ83uEpELI7GPz5Kxl
	RdIBz6rMDDoh3BGXBeCL02sMn1bQdL2VY7j8NUb+SkPEo0g=
X-Google-Smtp-Source: ACHHUZ5EU7suuKJ7Zdc/zHGsN5rUVVmE1BBfceW4PsW5ZlL9Nb5CEr00kUJPUcZXtj+gPQVQU97hrTdGHo57vn9bYb0=
X-Received: by 2002:a05:6808:14a:b0:3a0:5c3e:dd49 with SMTP id
 h10-20020a056808014a00b003a05c3edd49mr8794352oie.30.1687649230810; Sat, 24
 Jun 2023 16:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Vinicius Petrucci <vpetrucci@gmail.com>
Date: Sat, 24 Jun 2023 18:26:34 -0500
Message-ID: <CAEZ6=UPwe8jUD4B4G5n8drBf3HieQ=-KsY6fs2MPh0xtQxeMgg@mail.gmail.com>
Subject: Issues getting per-numa heatmap via "paddr" tracking
To: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

I've cloned the latest damo user-space tool to try generating a
heatmap on a per-NUMA basis using DAMON's "paddr" feature.
I wrote a simple script using "damo" and "masim" as workload
controlled (via numactl) to use NUMA 0 for both CPU and memory
allocation, but I am not seeing any accesses on the target NUMA region
(say, NUMA 0)

I analyzed the debug output of the damo tool and I could see that at
least the _initial_ region was created macthing the NUMA address range
in my system.

write '4294967296' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/0/start'
write '824633720831' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/0/end'

# lsmem -r -o NODE,RANGE,ZONES,SIZE
NODE RANGE ZONES SIZE
0 0x0000000100000000-0x000000bfffffffff Normal 764G

>>> 0x0000000100000000
4294967296
>>> 0x000000bfffffffff
824633720831

So, I am not sure what is happening. Thoughts?
Am I missing anything or doing anything wrong?
(See scripts and results below)

Thanks!

------------

System details:
# uname -a
Linux 6.1.35

# perf version
perf version 6.3.9-1.el9.elrepo.x86_64

# damo features
fvaddr: Supported
init_regions: Supported
init_regions_target_idx: Supported
paddr: Supported
record: Unsupported
schemes: Supported
schemes_filters: Unsupported
schemes_prioritization: Supported
schemes_quotas: Supported
schemes_speed_limit: Supported
schemes_stat_qt_exceed: Supported
schemes_stat_succ: Supported
schemes_tried_regions: Unsupported
schemes_tried_regions_sz: Unsupported
schemes_wmarks: Supported
vaddr: Supported

# lsmem -r -o NODE,RANGE,ZONES,SIZE
NODE RANGE ZONES SIZE
0 0x0000000100000000-0x000000bfffffffff Normal 764G
1 0x000000c080000000-0x000000fc7fffffff Normal 240G
1 0x0000010000000000-0x00000183ffffffff Normal 528G

----- BASH ------

numactl -N 0 -m 0 /opt/masim/masim
/opt/masim/configs/stairs_30secs.cfg 1> stairs.log & masim_pid=$!
/opt/damo/damo record paddr --debug_damon --numa_node 0 1> damo.log &
damo_pid=$!
wait $masim_pid
kill $damo_pid
sleep 5
wait $damo_pid
/opt/damo/damo report heats --heatmap stdout

--------- OUTPUT ----

[ perf record: Woken up 4 times to write data ]
[ perf record: Captured and wrote 1.731 MB damon.data (10601 samples) ]
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
# access_frequency:  0  1  2  3  4  5  6  7  8  9
# x-axis: space (4294967296-826781204416: 766.000 GiB)
# y-axis: time (26583584434000-26611562269000: 27.978 s)
# resolution: 80x40 (9.575 GiB and 699.446 ms for each character)

# cat stairs.log
initial phase:               293,863 accesses/msec, 5000 msecs run
phase 0:                     293,915 accesses/msec, 2500 msecs run
phase 1:                     290,245 accesses/msec, 2500 msecs run
phase 2:                     293,968 accesses/msec, 2500 msecs run
phase 3:                     292,185 accesses/msec, 2500 msecs run
phase 4:                     305,397 accesses/msec, 2500 msecs run
phase 5:                     292,657 accesses/msec, 2500 msecs run
phase 6:                     290,874 accesses/msec, 2500 msecs run
phase 7:                     291,556 accesses/msec, 2500 msecs run
phase 8:                     304,506 accesses/msec, 2500 msecs run
phase 9:                     292,709 accesses/msec, 2500 msecs run

# cat damo.log
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/nr_contexts': '1'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/nr_regions/min':
'3'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/nr_regions/max':
'3'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/intervals/sample_us':
'10000'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/intervals/aggr_us':
'100000'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/intervals/update_us':
'1000000'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/operations': 'paddr'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/nr_targets': '1'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/nr_regions':
'3'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/1/end':
'1084479242239'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/1/start':
'826781204480'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/2/end':
'1666447310847'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/2/start':
'1099511627776'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/0/end':
'824633720831'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/0/start':
'4294967296'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/pid_target':
'0'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/schemes/nr_schemes': '0'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/avail_operations': 'vaddr
fvaddr
paddr'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'off'
read '/sys/kernel/mm/damon/admin/kdamonds/0/pid': '-1'
read '/sys/kernel/mm/damon/admin/kdamonds/nr_kdamonds': '1'
read '/sys/kernel/mm/damon/admin/kdamonds/nr_kdamonds': '1'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/nr_contexts': '1'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/nr_targets': '1'
write '0' to '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/nr_targets'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/schemes/nr_schemes': '0'
write '1' to '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/schemes/nr_schemes'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/avail_operations': 'vaddr
fvaddr
paddr'
read '/sys/kernel/mm/damon/admin/kdamonds/nr_kdamonds': '1'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/nr_contexts': '1'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/nr_targets': '0'
write '1' to '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/nr_targets'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/nr_regions':
'0'
write '3' to '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/nr_regions'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/schemes/nr_schemes': '1'
write '0' to '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/schemes/nr_schemes'
write 'paddr' to '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/operations'
write '10000' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/intervals/sample_us'
write '100000' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/intervals/aggr_us'
write '1000000' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/intervals/update_us'
write '3' to '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/nr_regions/min'
write '3' to '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/nr_regions/max'
write '' to '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/pid_target'
write '4294967296' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/0/start'
write '824633720831' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/0/end'
write '826781204480' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/1/start'
write '1084479242239' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/1/end'
write '1099511627776' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/2/start'
write '1666447310847' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/2/end'
read '/sys/kernel/mm/damon/admin/kdamonds/nr_kdamonds': '1'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'off'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/nr_contexts': '1'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/nr_regions/min':
'3'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/nr_regions/max':
'3'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/intervals/sample_us':
'10000'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/intervals/aggr_us':
'100000'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/intervals/update_us':
'1000000'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/operations': 'paddr'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/nr_targets': '1'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/nr_regions':
'3'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/1/end':
'1084479242239'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/1/start':
'826781204480'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/2/end':
'1666447310847'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/2/start':
'1099511627776'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/0/end':
'824633720831'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/0/start':
'4294967296'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/pid_target':
'0'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/schemes/nr_schemes': '0'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/avail_operations': 'vaddr
fvaddr
paddr'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'off'
read '/sys/kernel/mm/damon/admin/kdamonds/0/pid': '-1'
read '/sys/kernel/mm/damon/admin/kdamonds/nr_kdamonds': '1'
read '/sys/kernel/mm/damon/admin/kdamonds/nr_kdamonds': '1'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/nr_contexts': '1'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/nr_targets': '1'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/nr_regions':
'3'
write '28' to '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/nr_regions'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/schemes/nr_schemes': '0'
write 'paddr' to '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/operations'
write '5000' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/intervals/sample_us'
write '100000' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/intervals/aggr_us'
write '1000000' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/intervals/update_us'
write '10' to '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/nr_regions/min'
write '1000' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/nr_regions/max'
write '' to '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/pid_target'
write '4096' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/0/start'
write '655360' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/0/end'
write '1048576' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/1/start'
write '1975517184' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/1/end'
write '1976205312' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/2/start'
write '1976565760' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/2/end'
write '1979711488' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/3/start'
write '2567876608' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/3/end'
write '2567880704' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/4/start'
write '2569625624' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/4/end'
write '2569625624' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/5/start'
write '2570024536' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/5/end'
write '2570024536' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/6/start'
write '2570027032' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/6/end'
write '2570027032' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/7/start'
write '2570425944' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/7/end'
write '2570425944' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/8/start'
write '2570428440' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/8/end'
write '2570428440' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/9/start'
write '2570494040' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/9/end'
write '2570494040' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/10/start'
write '2570498072' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/10/end'
write '2570498072' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/11/start'
write '2570562648' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/11/end'
write '2570562648' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/12/start'
write '2570563608' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/12/end'
write '2570563608' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/13/start'
write '2570623064' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/13/end'
write '2570623064' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/14/start'
write '2570625048' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/14/end'
write '2570625048' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/15/start'
write '2570686040' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/15/end'
write '2570686040' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/16/start'
write '2570686488' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/16/end'
write '2570686488' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/17/start'
write '2570751064' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/17/end'
write '2570751064' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/18/start'
write '2570752024' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/18/end'
write '2570752024' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/19/start'
write '2570816600' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/19/end'
write '2570816600' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/20/start'
write '2570817560' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/20/end'
write '2570817560' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/21/start'
write '2571045464' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/21/end'
write '2571045464' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/22/start'
write '2571046936' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/22/end'
write '2571046936' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/23/start'
write '2571274840' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/23/end'
write '2571274840' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/24/start'
write '2594201600' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/24/end'
write '2596564992' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/25/start'
write '2716004352' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/25/end'
write '2787110912' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/26/start'
write '2818560000' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/26/end'
write '4294967296' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/27/start'
write '826781204480' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/27/end'
write 'on' to '/sys/kernel/mm/damon/admin/kdamonds/0/state'
read '/sys/kernel/mm/damon/admin/kdamonds/nr_kdamonds': '1'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
Press Ctrl+C to stop
read '/sys/kernel/mm/damon/admin/kdamonds/nr_kdamonds': '1'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'on'

signal 15 received
write 'off' to '/sys/kernel/mm/damon/admin/kdamonds/0/state'
read '/sys/kernel/mm/damon/admin/kdamonds/nr_kdamonds': '1'
read '/sys/kernel/mm/damon/admin/kdamonds/0/state': 'off'
read '/sys/kernel/mm/damon/admin/kdamonds/nr_kdamonds': '1'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/nr_contexts': '1'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/nr_targets': '1'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/nr_regions':
'28'
write '3' to '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/nr_regions'
read '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/schemes/nr_schemes': '0'
write 'paddr' to '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/operations'
write '10000' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/intervals/sample_us'
write '100000' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/intervals/aggr_us'
write '1000000' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/intervals/update_us'
write '3' to '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/nr_regions/min'
write '3' to '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs/nr_regions/max'
write '' to '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/pid_target'
write '4294967296' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/0/start'
write '824633720831' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/0/end'
write '826781204480' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/1/start'
write '1084479242239' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/1/end'
write '1099511627776' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/2/start'
write '1666447310847' to
'/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/2/end'
