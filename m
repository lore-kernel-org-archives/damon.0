Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F142BAF0
	for <damon@lists.linux.dev>; Sun,  7 Jul 2024 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720367075; cv=none; b=grqvWshekGsMKQ0YIvet4DAZDjZNyIvJBlK0dio/kamnrLCWop96MvI92GuTzZUNoQ0S4j2j+i2Q9wJrxZmm5NJ2VHjxuXiJir+3b7RgKX7kIhyFmcqDfS3koBNHcWjnxbd4jny3XXFmr7sR2NPvDRYIdMXRtY6CMXWw5CJHvts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720367075; c=relaxed/simple;
	bh=rfh5ejnUKDUF97vTImVmbiYlu6frF3yu68+qEVv2Y7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dR09RIBpfRWgZei74iiwI8UNil6bhEsQHFeVj8T7SCcIwATO7LQbXPop+sZbTAbI5B3KhYZeifDzo4FpbfX84Dn2PLEYD2BXdNaGGihFyniXb2vuja82w6oQI02BU+srYXUesF/xRL9bg313d22jGPf2cillI+gC1rb7hcBsiLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNXb+dtK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNXb+dtK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C38C3277B;
	Sun,  7 Jul 2024 15:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720367075;
	bh=rfh5ejnUKDUF97vTImVmbiYlu6frF3yu68+qEVv2Y7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aNXb+dtKH7s7ItamI+cgdR3vS5phwKiTIUoaLlYDufil6gSSYNHkZcoY64xCCSnJh
	 yynhJKwXi5BKPyNL+kKa6iQtEg6nKgD61KfXlOnxrJztjyKQ9UKK6eIU9WPVLxTZ6h
	 jY/MjHaabCXCVspGZV5N0Mr8ptrewz6cidJ+FfBN7FWW8FgMCKI9x1Afi2/c4z9qeS
	 dwodGPqaH/oJu+A2iYyeQ8mEnVuDt8RzrNmqQfTdd0UoeRoCWcDw5bYqMck1Hb5ciw
	 ErR72cJGo2B8yMpkbAqd5Oxrxl+o9Z+6LYkmEoOUK4Ef4La1FpMbiclyizOSlL2Ipj
	 jPWlbwPfTGhkQ==
From: SeongJae Park <sj@kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mel Gorman <mgorman@suse.de>,
	Balbir Singh <bsingharora@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-mm@kvack.org,
	damon@lists.linux.dev
Subject: Re: Tools for explaining memory mappings/usage/pressure
Date: Sun,  7 Jul 2024 08:44:27 -0700
Message-Id: <20240707154428.77697-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <29c27dab-a590-5df2-c840-279bf9dff090@google.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David,

On Sat, 6 Jul 2024 13:55:11 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:

[...]
> Rather than hacky scripts that collect things like vmstat, memory.stat, 
> buddyinfo, etc, at regular intervals, it would be preferable to hand off 
> something more complete.  Idea is an open source tool that can be run in 
> the background to collect metrics for the system, NUMA nodes, and memcg 
> hierarchies, as well as potentially from subsystems in the kernel like 
> delay accounting.  IOW, I want to be able to say "install ${tool} and send 
> over the log file."
> 
> Are thre any open source tools that do a good job of this today that I can 
> latch onto?

DAMON user-space tool, damo[1], provides background recording and reporting of
memory access information including size of memory showing specific access
pattern (e.g., working set size).  Nowadays we're extending the tool to capture
and provide more information for holistic and intuitive system investigations.
Currently basic memory footprints and CPU usage of functions are provided.

The current status of the tool would be far from what you're looking for,
though.  I'm also not sure if current future plan of the tool would perfectly
meet your requirements.  We're open to any contributions to damo, though.

Hopefully others may know better tools for this.  I'm looking forward to a
chance to learn from those.

> If not, sounds like I'll be writing one from scratch.  Let me 
> know if there's interest in this as well.

We're open at not only receiving contributions for damo, but also providing
contributions to other projects (and using it).  So, yes, I'm interested in
this :)

[1] https://github.com/awslabs/damo

Thanks,
SJ

> 
> Thanks!
