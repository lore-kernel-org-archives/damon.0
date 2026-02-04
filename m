Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C283A227EB9;
	Wed,  4 Feb 2026 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770189434; cv=none; b=mQVLt4nnzeywR8GuWuYvhHZsvPNeNtxNs0xxja0PRQ2uqRH49etUBMG4dDz7eJbsLUAs4dAa1xa9kjDF9Tz1Q2X/qh8n9uqWGDpfuFLDNqVQl7Fhu3MMbeLk0TsD/hglQdYpFu0p6dV0OPqvd91K2V+Q1ZWM8KrqOpU6hNgwTwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770189434; c=relaxed/simple;
	bh=PbpHINPIxKlo9HPoQQXP6SMwz/+sggXsDbHwfHXEEkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiDnwuIKzXI4guxC2Qd1oSAO99YlpeOB3CgQiI59OiR7uNUQwOURoAWrsYU1ZLrMMBxZJcXhmEuV5gtNTN8EYhqz0SgVKAfUUA56SOeWnsssUVozmREB+ZqC1pA2Yljd8TEhhA+z6XQa4N7Ft9JMkLEm+rrB9i8Kw+7STrqz3BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alX5ja/r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alX5ja/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4028CC4CEF7;
	Wed,  4 Feb 2026 07:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770189434;
	bh=PbpHINPIxKlo9HPoQQXP6SMwz/+sggXsDbHwfHXEEkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=alX5ja/rxhvf5yBZcCNXHG6rAaG5VEkuC40wnmWvqMN6tM20LdqGLTogEH39uhSgK
	 H/Q9S7C8aF1gsQKYdz1rjlPs0uHp8T5ZY1vGAiHOEhZtXr3O3jM9ytNzuozft2XdPj
	 CFnhrg65NijjL3rspj1ZmBNWZzWV2ACtewNPl+b0+SXsRupHsfoLW1jd/c/dm9vmX7
	 Z96d40SD/Ob8bq89SOm6B2UEOncXijT9pARMFVg6wnaOLyw4sqAnFwSxtCEyuk5+vV
	 LpKs3AxRrLThnBl1CCr6m7V7lSwiF3Bc2jZXElLj9ZO6REzoVMBVZM03dkLzYR5dke
	 VQphjGTIq7o7Q==
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
Subject: Re: [RFC PATCH v1 0/4] mm/damon: Support hot application detections
Date: Tue,  3 Feb 2026 23:17:11 -0800
Message-ID: <20260204071712.16325-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <af4f3e15-a306-4728-b5bf-1deaa700c99b@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 3 Feb 2026 17:25:11 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> SeongJae,
> 
> Thanks a lot for all the useful feedback.

The pleasure is mine! :)

> 
> One thing that I was not sure about while working on this patch set
> is whether to have an external new module or adding the logic to 
> damon core. I mean, the hot application detecting can be useful for
> all other modules and can improve DAMON performance.

All exising non-sample DAMON modules are working for the physical address
space.  I hence finding no many opportunities to bring benefits of hot
application detection to those.

I agree the hot applications detection could be useful in general and creative
DAMON use cases for virtual address spaces.  Implementing the feature in DAMON
core layer and exposing it via DAMON sysfs interface will help such use cases.
But it seems not straightforward to imagine how the sysfs interface can be
extended for the feature.

So, I think it would better to be implemented inside the new module at the
moment.  Later, if we end up having more modules that use the feature, we could
move it to the modules-common or the core.  If we further find a good way to
integrate that with sysfs interface, definitely it could go to core.

From this point, however, I realize the feature can also be implemented in the
user sapce in a pretty straightforward way.  Have you considered that?

> What do you think?
> My implementation was module based because I tried to avoid changes
> to DAMON core for the RFC.

If there is a good reason to implement that not in the user space but the
kernel space, as I mentioned above, it seems the module is the right place to
me.


Thanks,
SJ

[...]
