Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D8426E6F2
	for <damon@lists.linux.dev>; Fri, 12 Dec 2025 03:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765510689; cv=none; b=rB7Ku7Hk9j62qAW3MK/JKMEDIZSNP+rJw54pKLCGtBaZo8wIU1Pjg0PZH9Qsfgu+rmBU/ctVkQrzKhqdH+4mJukioyHC9JsRvyweImOSSBfM+BKhYNzI9u+fPWLCERGyi8g+aDvBxzjERmPNIrkbx2dqfpgyAFHK8jsVkSXwslE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765510689; c=relaxed/simple;
	bh=Td11YCdlKUJ7FHmE410jVInO0wKwvj4dwWtCXzArXFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQWttQnK8UD/f33fK1E5Cl72TlekcHZl6L8Yc6ZI8Un6R4jh+CszeIYoBQiso4h2qUf/NRPPTINPRkqDaUGX/gi/e0EGs6uIUB4bBpstsszUWN1NqW5WOOLbLQpv07OXowga+ooJzM9Yw8CfLkheeHSGnmWkbIUyNXhjpGAwfJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaDCkIY3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaDCkIY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A88C116B1;
	Fri, 12 Dec 2025 03:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765510688;
	bh=Td11YCdlKUJ7FHmE410jVInO0wKwvj4dwWtCXzArXFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iaDCkIY36BXWA8Nrkj85IiL5qnS2jVrpd7Qt+t9Wx3T1pO2IDGgY6jszW08m6Wu23
	 ntPSzRo+9LVDxfy47lmlZeHjMnD6bOPHSebCwBwo+vWAvrbbChlug5eCdKhdBdYm25
	 7YUgzi+5+jQ6ZD0nR+AaXG/4nrT6l6OgVoBNLTmIVcUfcMUGTlXlHrqXhlr8KDosEo
	 VEVOe49x/979Sm8zK/zEQU5YIPXrDDCm40kKJ53/SB3zQA60OR8d6sZtY76ODAI/4h
	 2rRQs0Hd8XDFe410YDc29kzkOcvZ/rnzsec4fGbbKakUILWbpzo8RhGArHSYEpGPPO
	 oDHscKOWdQmRA==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [RFC PATCH 0/2] mm/damon: Introduce basic auto-tuning framework with priority support
Date: Thu, 11 Dec 2025 19:38:04 -0800
Message-ID: <20251212033804.40832-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251209145026.3263754-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  9 Dec 2025 22:50:24 +0800 Enze Li <lienze@kylinos.cn> wrote:

Sorry for late response!

> Currently, users need to manually tune multiple parameters (e.g.,
> watermarks, quotas) for different workloads when using DAMON.  This
> increases the barrier to entry and complicates adoption.

I cannot agree this more!

> This patchset
> aims to lower this barrier by introducing a basic auto-tuning
> framework for DAMON, which allows the system to automatically adapt
> DAMON's operational parameters based on user-provided hints and system
> state.
> 
> The core idea is to allow users to assign a simple priority level to
> each monitoring target.  Based on these priorities and the current system
> conditions (initially focusing on free memory), the framework
> dynamically adjusts DAMON's parameters.  The initial implementation
> focuses on the automatic management of watermarks.

How difficult watermarks tuning is?  Do you have some real use case or
realistic benchmarks showing it?  Could you please share that?

> 
> While the auto-tuning functionality could be implemented in user space
> as a separate daemon, integrating it directly into the DAMON kernel
> subsystem offers distinct advantages essential for a memory management
> automation feature.  First, it delivers superior performance and
> real-time responsiveness by executing tuning logic within the monitoring
> thread (kdamond) context, eliminating the latency and overhead of
> frequent kernel-user space context switches and system calls.  This
> ensures parameter adjustments can keep pace with DAMON's monitoring
> cycles.  Second, it provides inherent reliability as the tuning logic
> becomes an integral part of the DAMON context, immune to failures of any
> user-space process (e.g., termination by the OOM killer) and requiring
> no additional service management.  Finally, it offers a simplified,
> out-of-the-box experience where users enable auto-tuning through a
> single configuration without needing to install, maintain, or ensure
> version compatibility of an external tool.  This kernel-based approach
> aligns with the goal of creating a robust, low-overhead, and truly
> self-adaptive memory management subsystem.

I agree your points.  In-kernel auto-tuning is much more efficient and simple
to use, compared to user-space based ones.  Nonetheless, the disadvantage of
in-kernel auto-tuning is it increases the maintenace burden.  I'd like to add
lengthy change only if it shows clear benefit.

From this cover letter, I show only "potential" future benefits that might not
land on the real world.  Do you have some real use case or realistic benchmarks
showing the benefit you explained above?  If so, could you please share those?


Thanks,
SJ

[...]
