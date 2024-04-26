Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2072B2232A
	for <damon@lists.linux.dev>; Fri, 26 Apr 2024 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161851; cv=none; b=KdK6v5vLu1g3BiBR0Sz6lOZggwd4NRZT4d3DiaTWhKXZQ/IIscukEnhexfhbxj+aCanberYY9YFpMhRVZow05KQqNGMlmKgR52MZ0JvxEhqXZXuTY4f7PPP7f1GBqHeJbZzZ3cLYi01m3t/a+2mkCC+DYCWUc5DN0s+vHwUp/9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161851; c=relaxed/simple;
	bh=gHnh8P+t9/HBBiqlZNc7ytcFU5qE0Akv4uHOQqt7FOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I2KAubNsvttY054XT3yF3jXl9k95rHwzDmb13JVG5egM8fDK/T9mgFniiCFgjSOZtZd+gmNKRtdvj057vP2DkpGuD5qjYtcjCzheMN4Uu+6oX8YMOwASYVIlgOb97IfPYiweZ1aawq9TtzWUOBbsuRx0kUUz63fT4bo+zgMTYjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMISQJbn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMISQJbn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64474C113CD;
	Fri, 26 Apr 2024 20:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714161850;
	bh=gHnh8P+t9/HBBiqlZNc7ytcFU5qE0Akv4uHOQqt7FOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WMISQJbnQeJL/r+V9wWj9FZoJOA9mXXZ8Q4xLGf3jYZnfQSpJb8IBxXsTc91L0GTl
	 OT3HI1IkUMb2cOVevVHwgLA8CMVr4S0PclL2mTVJ+MSfbrQnO9uopQg6C4gxI5WcbW
	 mMxKe9H1JBQ5CGGF3vbvoV4Q2jIQE9V1CRFQDqCFm6cQ8cuZ6esK30ylsGEgNt/Xbi
	 1Qxb65oikWks+Gbqk31Dg5o3SICm1/izVOEwsFngYEOWVlSxOIYMY2gCRMcysxWFGi
	 OTsYOe4veGY28JJuahIFzrO3E8WE42lfZ9yEp4aNSqnvthkzBAVDWWU9qP5TzoV6YY
	 cd/y3x8WKyMYA==
From: SeongJae Park <sj@kernel.org>
To: lokesh jaliminche <lokesh.jaliminche@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: Regarding DAMON sysfs usage to get memory access stats
Date: Fri, 26 Apr 2024 13:04:08 -0700
Message-Id: <20240426200408.100431-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAKJOkCr86bMoOgxnJQu8Ry-W-2XHYn_xgyZWL4pTPCgcGK3_rg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lokesh,


Sorry for late reply.  Somehow I missed this mail.

On Mon, 22 Apr 2024 17:51:21 -0700 lokesh jaliminche <lokesh.jaliminche@gmail.com> wrote:

> Hi Everyone,
> 
> I am currently experimenting with DAMON to gather memory access
> statistics for virtual address ranges associated with specific
> processes. I have followed the detailed instructions provided in the
> usage documentation, but it's unclear where to find the resulting
> memory access statistics.
>  Any pointers on where to get these statistics?
> 
> Steps
> # cd /sys/kernel/mm/damon/admin/
> # echo 1 > kdamonds/nr_kdamonds && echo 1 > kdamonds/0/contexts/nr_contexts
> # echo vaddr > kdamonds/0/contexts/0/operations
> # echo 1 > kdamonds/0/contexts/0/targets/nr_targets
> # echo $(pidof masim) > kdamonds/0/contexts/0/targets/0/pid_target
> # echo on > kdamonds/0/state

After the above steps, you can get the monitoring results from 'tried_regions'
directory[1] of the sysfs interface, or by collecting damon:damon_aggregatred
tracepoint[2].

However, I'd recommend using the user-space tool, 'damo'[3], if you could.  It
provides more human-friendly interface and visualization of the monitoring
results.  For example, the above step could be reduced to single command like
below:

    $ sudo damo start $(pidof masim)

Then you could show the monitoring results snapshot in realtime like below:

    $ sudo damo show
    0   addr [4.000 GiB   , 16.245 GiB ) (12.245 GiB ) access 0 %   age 7 m 32.100 s
    1   addr [16.245 GiB  , 28.529 GiB ) (12.284 GiB ) access 0 %   age 12 m 40.500 s
    2   addr [28.529 GiB  , 40.800 GiB ) (12.271 GiB ) access 0 %   age 15 m 10.100 s
    3   addr [40.800 GiB  , 52.866 GiB ) (12.066 GiB ) access 0 %   age 15 m 58.600 s
    4   addr [52.866 GiB  , 65.121 GiB ) (12.255 GiB ) access 0 %   age 16 m 15.900 s
    5   addr [65.121 GiB  , 77.312 GiB ) (12.191 GiB ) access 0 %   age 16 m 22.400 s
    6   addr [77.312 GiB  , 89.537 GiB ) (12.225 GiB ) access 0 %   age 16 m 24.200 s
    7   addr [89.537 GiB  , 101.824 GiB) (12.287 GiB ) access 0 %   age 16 m 25 s
    8   addr [101.824 GiB , 126.938 GiB) (25.114 GiB ) access 0 %   age 16 m 25.300 s
    total size: 122.938 GiB

The above is only a small part of the features of the tool.  You can get more
details of the tool from its usage document[4].

[1] https://docs.kernel.org/admin-guide/mm/damon/usage.html#sysfs-schemes-tried-regions
[2] https://docs.kernel.org/admin-guide/mm/damon/usage.html#tracepoints-for-monitoring-results
[3] https://github.com/awslabs/damo
[4] https://github.com/awslabs/damo/blob/next/USAGE.md


Thanks,
SJ

> 
> Thanks & Regards,
> Lokesh
