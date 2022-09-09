Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946E76AA5
	for <damon@lists.linux.dev>; Fri,  9 Sep 2022 23:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D264DC433D6;
	Fri,  9 Sep 2022 23:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662764424;
	bh=f/7dJ5txgGxEVcbNQbggz7c0bBv4vFnX6giz7/h7ftA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s/vk82qK4O+vymiABD4L2SfJe9CfTJlUDAy5G7oIRlyj3Prygy5S27vbNAXVFhKJA
	 oAbjjcTp5S0fatq2klxDqoBs0OX0vB0pY/nYc/KJx/i3WBcKSCeaNhnxPDgJDQngbU
	 NzOM5kWmqpls5cHBHrOZMdANEfK8qittiqo28ob1UGYQyTbdY3hEe6DHPpAqkZbeeo
	 HL0WJplG7wBxIah4XUlpMZO8Ru/uKeDFogzsZLnGCdNrbaDXYfai4nEM41p6IfpKhE
	 E9mEi6PUNZbDedqcATGtGQNbo0LgeV/VmT9yWrde/T1JGZW9Vt85YQ2cRaXfPRc7Nm
	 rhEbzYWiyZAjw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Xin Hao <xhao@linux.alibaba.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs: change few functions execute order
Date: Fri,  9 Sep 2022 23:00:22 +0000
Message-Id: <20220909230022.51436-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909154434.5870e33657a11d53320861e7@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 9 Sep 2022 15:44:34 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu,  8 Sep 2022 22:16:53 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> Cool.  I rewrote the changelog significantly:
> 
> From: Xin Hao <xhao@linux.alibaba.com>
> Subject: mm/damon/sysfs: change few functions execute order
> Date: Thu, 8 Sep 2022 16:19:32 +0800
> 
> There's no need to run container_of() as early as we do.
> 
> The compiler figures this out, but the resulting code is more readable.

Looks very nice to me.  Thank you, Andrew!


Thanks,
SJ

[...]
