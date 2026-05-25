Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8005E3F4115;
	Mon, 25 May 2026 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727706; cv=none; b=s9hXXIomoqMkUEUYoTAsKDCs4x51AGFATMRrA3RQCVufYszYOn+kKQfRXq4A1k5IvAyxGUrTHOZ/zqyqIyh9qy7uY4f3c04pQqcSjz4hmJRoo8CFGkPdd5HDwOI+6xqldl60uhLFzx8TR4S8P1wRxkK0kSPiwOE04v+6Kis5A6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727706; c=relaxed/simple;
	bh=af6+gZaCDSq7EKDjZOeLsSr2suEvIuKwR/1pPwYTH3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJMD3nHJI9VGHO4tWDM+aG9paXUMm8pRIGsrqtL69hnXOQ+KJiUZpdfJvOChEX8L+TlxW2B9TjSUNoydsMpsVP5A+WV885sjdWm86sTswjDKt1RCNjzK0nsiq4381TeIRWTTPjLNf3T/m3N9VmuQ7qk9KXwxu1WvNHGhIvye1k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYW7aLWw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYW7aLWw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C321F000E9;
	Mon, 25 May 2026 16:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779727705;
	bh=X8+rOuAsw06eyL6NJoqLksg0G4h6H1UZY/EYUW4dvjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AYW7aLWw9P8M36AJuw5en93j8uTOmjGw8dW+zJWYXUxbA2d2yDHupGk7l1/L0HRbr
	 oMv1bauOvKGJw9Du/krlKcu4OysJEimCSPZ/L+6fIVs6AAjj1281k7BjxXMdp0UgdJ
	 ygrF/WvixQqhNUyvQpOcDtrNx+C2wJ5PCJ9mVAgM6wyfwnFsKg5byVkPEudyV0ADwO
	 8kJGAoJ7VyCW1HRjPTMvGsK17e+MiXYPraj9G4SXmaMVPtT9Usl1tcfYGmSv8qJCCk
	 In3ZvvkRInC1vLLTb38QK3r4Ob3gDeK7oVyFEPSLrOgqQZ0I2FWiRqWsJH+3UM7rNb
	 Z4wDIe5gBs9vQ==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] mm/damon: Introduce a huge page collapsing mechanism using auto tuning
Date: Mon, 25 May 2026 09:48:16 -0700
Message-ID: <20260525164816.8864-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <a746583d-af0e-401a-b1f8-d4a0e60d5cc3@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 25 May 2026 16:53:17 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> Hi SJ,
> 
> On 5/23/2026 8:17 PM, SeongJae Park wrote:
> > On Fri, 22 May 2026 14:55:14 +0000 <gutierrez.asier@huawei-partners.com> wrote:
[...]
> >> A new module is introduced to demonstrate the use of huge pages
> >> collapse autotuning. The goal is to collapse hot regions of a given
> >> process into huge pages. The module launches a kdamond thread for a 
> >> certain task provided by the user through monitored_pid module argument.
> >> Hugepage goal autotuning will automatically adjust the aggressiveness
> >> of hot region collapses.
> > 
> > Having a module for the demonstration purpose sounds good.  But, for the
> > demonstration purpose, as I previousoly commented, making it as a sample module
> > (put under /samples/damon/) or just drop when you drop RFC tag would be better.
> > 
> > Let me know if this module is aimed to be as is even after you drop RFC tag.
> I'll move it to samples. I'll keep the RFC in the next version still,
> so I make sure that the major details are polished before I drop RFC tag.

Makes sense.  In the case, I think we can further reduce the number of
parameters of the sample module and make the code simpler.

[...]
> >> TODO
> >> ====
> >> - Support page splitting for cold hugepages.
> > 
> > Sounds good!  By using two DAMOS schemes that doing collapsing and splitting, I
> > think we can make more complete access-aware THP system.
> My thought was to add cold page splitting as a separate RFC in the future.

Makes sense :)


Thanks,
SJ

[...]
