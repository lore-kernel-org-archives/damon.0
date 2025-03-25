Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F831ADFFB;
	Tue, 25 Mar 2025 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742936369; cv=none; b=T/XyV1pQn3OT2Pl2Ka2oNoKBUqXfFCSfeAdcjKQ+XFBPrq9qOoxxFK54wrqYQhqk1nQW2eFTZS0lYNVz38n877jFhPYOGeBHSlj430GCUysVLJaTby+XFor17etIYLoPbb3CGSKI8YO5pNs3l9JqlifQlvAPmQ32TddSJim/7AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742936369; c=relaxed/simple;
	bh=70VfOBNRBFCKf1/NSjObkjfWHMwkr7SvyN92QBMjylc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltl93UbFZriYngUNmZg2EQtJJxjx3IVQLsW6RM9L2lNjhe6HrZg7/J8aIGEOkUffRFpXxLlfxRSIPJfyLaKKLxA4rtWWZmgx2puSiGTo10E+2DxtBU200pxj8gw9yDUL/FCIbGPnFKYZAFd383X5BasB/n1+FbbxvKFOlSQUwF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NG8hEiJp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NG8hEiJp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4319AC4CEE4;
	Tue, 25 Mar 2025 20:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742936368;
	bh=70VfOBNRBFCKf1/NSjObkjfWHMwkr7SvyN92QBMjylc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NG8hEiJpJp6teO2kHDimHnqdHYQO1go2Z1cVqQG1nppDCmxU/FO1+Imwm4jsjkB2Z
	 2AApZufp9h0V06TEfODS3It32sJA9quYuhIAG8pguW9Rb/4VGfxBwuXdDtEsAda87+
	 dVftlwxJVGAcMrNU8aGuc0VMVYaalZ/ZwjZ7OAyA2NtdMKL6BB/Tkv768Eaa0Hymg+
	 fV29d6QypcuAdaaw2VFIWO6LvmHixy09Bz1s6Ade5mg6/b/tWrlqAZJcG0SwU+qVIo
	 fOAS4WD1tozCb7rg/23+Q080a4lM+0xG0+6w0iwBgzr7qrHN50PyUyYyzVV/ALrr/C
	 YQZruBQFAW5uQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [LSF/MM/BPF TOPIC] DAMON Updates and Plans: Monitoring Parameters Auot-tuning and Memory Tiering
Date: Tue, 25 Mar 2025 13:59:17 -0700
Message-ID: <20250325205918.843894-1-sj@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250102222317.48760-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Thu,  2 Jan 2025 14:23:17 -0800 SeongJae Park <sj@kernel.org> wrote:

> Hi all,
> 
> 
> We started sharing and discussing DAMON's current status and future plans from
> LSF/MM/BPF 2023.  Thanks to the constructive feedbacks from the discussions, I
> believe DAMON is continuing the evolution in right or at least not
> controversial directions.  To continue getting the benefit and avoid it becomes
> an unexpected "demon" in early stage, I'd like to share and discuss followup
> updates and new plans for DAMON once again on LSF/MM/BPF 2025.

A draft version of the slides for the session is now available at
https://github.com/damonitor/talks/blob/master/2025/lsfmmbpf/damon_updates_plans_lsfmmbpf_2025.pdf

I may make more last time changes to the slides, but the final version should
also be available on the same URL.


Thanks,
SJ

[...]
