Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2111F166
	for <damon@lists.linux.dev>; Thu, 13 Jul 2023 17:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2DDC433C8;
	Thu, 13 Jul 2023 17:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689268477;
	bh=kgxaa1OmUi80wUU09eMz3uSXbFRawfTYW16uKn9pf24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O9enzSDR3inIuil8WIAG09/xAJAbWJiCnSVyqmdzp05g0IW9UZ9oBdTnfPa8VrxzQ
	 zYqrSeCbUQKmZ7YFJk5HfS2D+JUw0my4NLGJcrVc7zbmjcO9RTtDbY//SxQ/Y5kHf2
	 qLlYjbTUi9PoqYkfxnfporWWhF2YLs4LseMnbfhWg7swKWEoSuo3XxW1ibd+5bhgiJ
	 XwMAHKqlWY8G3U+LMm4SR9xTSN0+MXzxgCyRKT4ZjMeoBtlhLHOSwLkshUE5McD80e
	 z1jV+Sc7Ngl9wLBIWIYhjSLWilWRfZFH881MQ0MgIF5b/mviRxztNwVx/BZnhNiAJx
	 mUdQ9aPqpwq2g==
From: SeongJae Park <sj@kernel.org>
To: Vinicius Petrucci <vpetrucci@gmail.com>
Cc: damon@lists.linux.dev,
	sj@kernel.org
Subject: Re: Issues getting per-numa heatmap via "paddr" tracking
Date: Thu, 13 Jul 2023 17:14:35 +0000
Message-Id: <20230713171435.66187-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAEZ6=UPwe8jUD4B4G5n8drBf3HieQ=-KsY6fs2MPh0xtQxeMgg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Vinicius,

On Sat, 24 Jun 2023 18:26:34 -0500 Vinicius Petrucci <vpetrucci@gmail.com> wrote:

Sorry for late response.  Somehow I missed this mail.

> Hi,
> 
> I've cloned the latest damo user-space tool to try generating a
> heatmap on a per-NUMA basis using DAMON's "paddr" feature.
> I wrote a simple script using "damo" and "masim" as workload
> controlled (via numactl) to use NUMA 0 for both CPU and memory
> allocation, but I am not seeing any accesses on the target NUMA region
> (say, NUMA 0)

Great.

> 
> I analyzed the debug output of the damo tool and I could see that at
> least the _initial_ region was created macthing the NUMA address range
> in my system.
> 
> write '4294967296' to
> '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/0/start'
> write '824633720831' to
> '/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/regions/0/end'
> 
> # lsmem -r -o NODE,RANGE,ZONES,SIZE
> NODE RANGE ZONES SIZE
> 0 0x0000000100000000-0x000000bfffffffff Normal 764G
> 
> >>> 0x0000000100000000
> 4294967296
> >>> 0x000000bfffffffff
> 824633720831
> 
> So, I am not sure what is happening. Thoughts?
> Am I missing anything or doing anything wrong?
> (See scripts and results below)

Thank you for this great and nice report!  I left my comment below.

> 
> Thanks!
> 
> ------------
> 
> System details:
> # uname -a
> Linux 6.1.35
> 
> # perf version
> perf version 6.3.9-1.el9.elrepo.x86_64
> 
> # damo features
> fvaddr: Supported
> init_regions: Supported
> init_regions_target_idx: Supported
> paddr: Supported
> record: Unsupported
> schemes: Supported
> schemes_filters: Unsupported
> schemes_prioritization: Supported
> schemes_quotas: Supported
> schemes_speed_limit: Supported
> schemes_stat_qt_exceed: Supported
> schemes_stat_succ: Supported
> schemes_tried_regions: Unsupported
> schemes_tried_regions_sz: Unsupported
> schemes_wmarks: Supported
> vaddr: Supported
> 
> # lsmem -r -o NODE,RANGE,ZONES,SIZE
> NODE RANGE ZONES SIZE
> 0 0x0000000100000000-0x000000bfffffffff Normal 764G
> 1 0x000000c080000000-0x000000fc7fffffff Normal 240G
> 1 0x0000010000000000-0x00000183ffffffff Normal 528G
> 
> ----- BASH ------
> 
> numactl -N 0 -m 0 /opt/masim/masim
> /opt/masim/configs/stairs_30secs.cfg 1> stairs.log & masim_pid=$!
> /opt/damo/damo record paddr --debug_damon --numa_node 0 1> damo.log &
> damo_pid=$!
> wait $masim_pid
> kill $damo_pid
> sleep 5
> wait $damo_pid
> /opt/damo/damo report heats --heatmap stdout

Nice!  I hope to have this kind of scripts in tests/ directory of 'damo'.

> 
> --------- OUTPUT ----
> 
> [ perf record: Woken up 4 times to write data ]
> [ perf record: Captured and wrote 1.731 MB damon.data (10601 samples) ]
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> 00000000000000000000000000000000000000000000000000000000000000000000000000000000
> # access_frequency:  0  1  2  3  4  5  6  7  8  9
> # x-axis: space (4294967296-826781204416: 766.000 GiB)
> # y-axis: time (26583584434000-26611562269000: 27.978 s)
> # resolution: 80x40 (9.575 GiB and 699.446 ms for each character)

As the last four lines of the output say, this output shows when (y-axis) which
regions (x-axis) are how frequently accessed (number), using 80 characters for
each region, and 40 characters for the entime time.  The size of the memory
region that monitored and displayed here is about 766 GiB.   The entire time of
the monitoring is similar to the runtime of 'masim', which is about 30 seconds.
Hence, each character shows the monitored access pattern of about 9.5 GiB and
699.446 ms, as above '# resolution' line says.

Meanwhile, the 'masim' run would accessed only 10MB region at one time.  Since
that's quite tiny amount of memory compared to the total monitored memory
region (766 GiB) and even compared to the single character of the output (9.5
GiB) due to the low resolution (80x40), the output couldn't show the access.
In short, you are visualizing memory region that very large compared to the
region that actual access has made, with too low resolution to show the small
regions of accesses.

I think you could use 'damo report raw' like command to show low level
monitoring results, or 'damo report wss' to show only regions shown accesses.


Thanks,
SJ

[...]
