Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B949919D8B3;
	Fri, 14 Jun 2024 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718383181; cv=none; b=L3kmboe7kAJKM3H31ARjmtBdO3WxTPKw1L7AG5jVdXTjMvoNLW6y3d1yl53wOzc3SeXLnc/fvHc2z2xEsOox6CNGHDLK9NGYTSkRYgwSOnCHLu8dI2vzTJEowLFMBAKT/Yq9YQJda++HIfNkwH3buUiWq9xFezFa+jno5MG2iXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718383181; c=relaxed/simple;
	bh=rQAw4/a1qgbkU6RaCZyZLYHMVr3338QIkfwOfXq06lY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=irbWu8vKcPAJZ9+nktynkkUd6bOBb9q+WP+Oi+vdBM3m1iFi1iBO7bz9Es35BW6uO00B9IungxLnupQ9KjpKxdys+1YugE7xe6HvyoKGPpUwIWnNePuyMbGVcuP0Bza2VzYVmx0vSWAFk9tZs807TQpS96MUkZUryDOojQ98Zak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZojFhx9R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZojFhx9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07463C2BD10;
	Fri, 14 Jun 2024 16:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718383181;
	bh=rQAw4/a1qgbkU6RaCZyZLYHMVr3338QIkfwOfXq06lY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZojFhx9R+LTcgFWvB6D579Bp8pIHrYMdVo1lmf347EF9750RL1fZP5YQ6cP5bx56J
	 KbS0QP56JtA/VXT8o3Kgf1w9YrMjSpiAf3gudn0XXCuYxa2vI+ha20167AnbL5WU0w
	 o438zH18o/mVxo5f1uJHdXuytusVP2RdnCx4OxulIN4B+FInAHbHeuxgxCeXgO99iu
	 ZBWRSgpQg4LbZpsx8VD8afNWprlGFHdxcRIg1L3UguxypEjqku93IHdHAARj0vnT59
	 LoSLUO5dUfHuxLEgKrCMeoHc8VF00mJFSssnmRQyYAIw2T4sWzw3R49KTJrsC/8U7b
	 vvi+/hkfl8fvw==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gregory Price <gregory.price@memverge.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com,
	kernel_team@skhynix.com,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Yunjeong Mun <yunjeong.mun@sk.com>
Subject: Re: [PATCH v6 0/7] DAMON based tiered memory management for CXL memory
Date: Fri, 14 Jun 2024 09:39:37 -0700
Message-Id: <20240614163937.85523-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240614030010.751-1-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 14 Jun 2024 12:00:02 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> There was an RFC IDEA "DAMOS-based Tiered-Memory Management" previously
> posted at [1].
> 
> It says there is no implementation of the demote/promote DAMOS action
> are made.  This patch series is about its implementation for physical
> address space so that this scheme can be applied in system wide level.
> 
> Changes from v5:
> https://lore.kernel.org/20240613132056.608-1-honggyu.kim@sk.com
>   1. Remove new actions in usage document as its for debugfs

Thank you, I confirmed this and gave you my Reviewed-by: tag.

>   2. Apply minor fixes on cover letter

But...

[...]
>   2. YCSB zipfian distribution read only workload (with demotion_enabled true)
>   memory pressure with cold memory on node0 with 512GB of local DRAM.
>   ====================+================================================+=========
>                       |       cold memory occupied by mmap and memset  |
>                       |   0G  440G  450G  460G  470G  480G  490G  500G |
>   ====================+================================================+=========
>   Execution time normalized to DRAM-only values                        | GEOMEAN
>   --------------------+------------------------------------------------+---------
>   DAMON tiered        |    -  1.03  1.03  1.03  1.03  1.03  1.07  1.05 | 1.04
>   DAMON lazy          |    -  1.04  1.03  1.04  1.05  1.06  1.06  1.06 | 1.05
>   DAMON tiered kswapd |    -  1.03  1.03  1.03  1.03  1.02  1.02  1.03 | 1.03
>   DAMON lazy kswapd   |    -  1.04  1.04  1.04  1.03  1.05  1.04  1.05 | 1.04
>   ====================+================================================+=========
>   CXL usage of redis-server in GB                                      | AVERAGE
>   --------------------+------------------------------------------------+---------
>   DAMON tiered        |    -   0.6   0.5   0.4   0.7   0.8   7.1   5.6 |  2.2
>   DAMON lazy          |    -   0.5   3.0   4.5   5.4   6.4   9.4   9.1 |  5.5
>   DAMON tiered kswapd |    -   0.0   0.0   0.4   0.5   0.1   0.8   1.0 |  0.4
>   DAMON lazy kswapd   |    -   4.2   4.6   5.3   1.7   6.8   8.1   5.8 |  5.2
>   ====================+================================================+=========
> 
> Each test result is based on the exeuction environment as follows.

Seems the typo is not fixed?

I don't want to delay this work for such trivial thing, though.  For the patch
series,


Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
