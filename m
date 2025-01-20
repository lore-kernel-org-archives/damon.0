Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E36156678
	for <damon@lists.linux.dev>; Mon, 20 Jan 2025 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737398799; cv=none; b=SPhos9Cy8gTJYpICz/2Qn5JVlC4fWp63Dw3GN+VFHePOZwcx5IZJxLgWikXTwfLCde6Kq+BV1xmqldwKcx7t9vmE7R8UIPAQc7i/PfE0VB51uXqaSZqQ0Qhc0+v+RcwKH3KA/w0O6awyZF2T/y+i5IfWln/ZT4+u7BmiWW4urI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737398799; c=relaxed/simple;
	bh=DBDqLqq24GozXAi9SY6l07yLmYcc/84YjRzesQvWQfA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUbj4h2E283ltFR1KTjyPLmlSHFrgF7CdufKou4hZbCIMO1m7Yd44M0Cti7hOibkyUEjC/nYGsWE5IfcVeDrUX3Zw8ereWo8FFGdZkkBn7AsqSgaHrH+B2d+5TjOLQ+1blH7FAKRpNMCSGmYU4noTAvnxLAWzdTR9uPh0GY7+c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YcK5532b3z67ZCl;
	Tue, 21 Jan 2025 02:44:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7095D1400CB;
	Tue, 21 Jan 2025 02:46:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 20 Jan
 2025 19:46:33 +0100
Date: Mon, 20 Jan 2025 18:46:32 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: SeongJae Park <sj@kernel.org>
CC: <lsf-pc@lists.linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	Raghavendra K T <raghavendra.kt@amd.com>, Yuanchu Xie <yuanchu@google.com>,
	Gregory Price <gourry@gourry.net>, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	Jiaming Yan <jiamingy@amazon.com>, Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [LSF/MM/BPF TOPIC] DAMON Requirements for Access-aware MM of
 Future
Message-ID: <20250120184632.00007b44@huawei.com>
In-Reply-To: <20250101222039.74565-1-sj@kernel.org>
References: <20250101222039.74565-1-sj@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed,  1 Jan 2025 14:20:39 -0800
SeongJae Park <sj@kernel.org> wrote:

> Hi all,
> 
> 
> I find a few interesting and promising projects that aim to do efficient access
> pattern-aware memory management of near future, including below (alphabetically
> sorted).
> 

Hi SJ,

> - CXL hotness monitoring unit
>   (https://lore.kernel.org/20241121101845.1815660-1-Jonathan.Cameron@huawei.com)

For hardware hotness monitors the type of data has relatively little connection
to what I understand Damon provides and the control schemes are somewhat different.
Hotness tracking units should provide a simple list of hot fixed size granuals
(hot 'pages') to whatever is using the hotness engine.  Damon and other in kernel
schemes might also be able to provide such outputs, but the underlying schemes
seem very different as the outputs of these trackers neither map to Damon regions,
or to dense sets of page counters.

So to me the commonality looks to be one layer up: We get lists of stuff
to consider moving and control paths to whatever is providing those lists
to indicate:
* More or fewer suggestions please (bandwidth controls etc)
* Minimum 'hotness' below which it should not suggest moving them.

For CXL Hotness monitoring units, there are open questions about how to get good
data given a limited resources likely to be found on devices. Simplest sense
can be thought of as a fixed set of counters, but typically it will be more
complex than that with statistical accuracy tradeoffs rather than did we
count it or not.

We need to do some work to find out what works best across many workloads
considering options (depending on hardware capabilities) such as
a) coarse to fine
b) random subsampling of 256MiB chunks of PA space.
c) scanning across PA space looking at a smallish region (16Gig maybe) at
   a time.
Also need to be flexible to use multiple parallel trackers if available on
a given device or time slices on a single tracker.

I'm not yet seeing enough different engines to figure out if there is
commonality in that control scheme between CXL style interfaces and those that
we may see from other places etc. If anyone is in a position to share info
on other hotness monitoring offloaded units that are targeting real products +
their interfaces that would be great. For now I think we are going to end
up with something specific in the CXL HMU driver with the rest of the kernel just
seeing a list of 'hot PA address chunks / pages in PA space'.

Given we will need a virtualized solution as well for guests that are running
on a fixed mix of tiers, I'd expect a "virtio-hotness" or similar that only
provides these sorts of generalized controls leaving the host to figure
out how to control the particular hotness trackers. The controls to that
would be inline with what I'd expect to be exposed to other layers of the
kernel from a given hotness tracker.

For me it feels like we are a bit early wrt to hardware trackers to come
to firm conclusions, but perhaps others are further ahead with
answering some of the precursor questions. I am keen that we don't
end up with a solution that doesn't work with them so this discussion
if of interest to me.

> - Memory tiering fainess by per-cgroup control of promotion and demotion
>   (https://lore.kernel.org/20241108190152.3587484-1-kaiyang2@cs.cmu.edu)
> - Promotion of unmapped page cache folios
>   (https://lore.kernel.org/20241210213744.2968-1-gourry@gourry.net)
> - Slow-tier page promotion based on PTE A bit
>   (https://lore.kernel.org/20241201153818.2633616-1-raghavendra.kt@amd.com)
> - Workingset reporting
>   (https://lore.kernel.org/20241127025728.3689245-1-yuanchu@google.com)
> 
> The goal of DAMON is to help accelerating such developments by being a
> framework that can reduce fundamental efforts for monitoring memory access
> patterns and managing memory using the information.  AWS Aurora Serverless v2
> and SK hynix are successfully using DAMON in the way for proactive memory
> reclamation[1] and CXL memory tiering[2].
> 
> To further deliver such benefits for the ongoing and future projects, we need
> to better understand what the projects really need, how DAMON can provide those
> now or in future, and if there are alternatives better than DAMON.  Regardless
> of the conclusion about DAMON, the works apparently have common parts, so the
> discussion will benefit all.
> 
> I propose to have the discussion at LSF/MM/BPF.  In the session, I will briefly
> introduce the works and possible DAMON usages, and continue the open discussion
> for better understanding each other.  The discussion will not be limited to
> DAMON and abovely mentioned projects but possible alternatives and general
> access-aware memory management projects.  After the discussion, we will
> hopefully find ways to efficiently collaborate, or at least do not disturb each
> other.

I like that last comment :)

Jonathan

> 
> [1] https://assets.amazon.science/ee/a4/41ff11374f2f865e5e24de11bd17/resource-management-in-aurora-serverless.pdf
> [2] https://github.com/skhynix/hmsdk/wiki/Capacity-Expansion
> 
> 
> Thanks,
> SJ

