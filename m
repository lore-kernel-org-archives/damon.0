Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5336A3201
	for <damon@lists.linux.dev>; Fri, 17 Jun 2022 17:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED6BC3411B;
	Fri, 17 Jun 2022 17:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655485476;
	bh=Q+XBhx/vteeW7cY3rY5sHIYqmY6k0VmCg+ASwPKQkds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oWfuQCkAGMmqCNPCn/uh9zedk/HJSqCAkJzhdrK9FtL8CUOquuOcTZhmAnLJdAaWV
	 OOhlZcMUplyoT2ns5cyVfFyIsq/J3uFEKGUojnR3y5GT+d10QVbon6gjig0414sfso
	 hMc/MZWeGDkyEMS9VaSecJvGsSbj6Zx2lpJVdkLI30Gh0h2mvPvOUeou6qK6L2ZZiN
	 3RotIIuC2Sn72xvwC5ymrRNfUPU7CavUVjfEYRmWkezVj+BuYvh9rnjfVjpmN8+5Pq
	 OasKuQ6rZ423dUzaPIlmPeNEHutjjtpIZb6a/IWiJxAepD94C177f2yx1OLQCjWcgB
	 mzX7G9QYv1xqQ==
From: SeongJae Park <sj@kernel.org>
To: Xin Hao <xhao@linux.alibaba.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: about DAMON lru_sort
Date: Fri, 17 Jun 2022 17:04:34 +0000
Message-Id: <20220617170434.106076-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <65066228-82f7-84a4-6fcc-d8954da60369@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xin,

On Fri, 17 Jun 2022 18:00:30 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> Hi sj,
> 
> I have another question,  if the mglru patch merge into upstream, which 
> is more accurate, whether it can be proved with test data, or 
> combination them to use ?

I think a fair comparison should be made with fair amount of combinations, of
course.

I'm unsure if I'm fully understanding your question.  Could you please clarify
your points?


Thanks,
SJ
[...]
