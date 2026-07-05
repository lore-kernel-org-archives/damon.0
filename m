Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596192FE074
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783269709; cv=none; b=OMExHwYFhBZw6iG5ULZqSUT2i0e98ot37H9Hbm8loGtJC04btX1DRkeOHQoLlzcO+q6xgHnzeyzI57/SgPW0a9HbUT6YaNaBCvsx1gABcZW0oCrlbj6HMG3LgnrVMj+vArqQFfaxhZqDwdUAio1QEO+8mMrOuTZYR+ENnYe/TaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783269709; c=relaxed/simple;
	bh=JzB0a1ZSzqBwYWnm8ay0Qy6ifmNEsgxvxDdRi2owipk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANmhV5/W11xXofG4ed9CY+5MaxKrI/bOTvOPPsVAzpEEv5Vz6BRB+UjWRJ4+mTDffyq0lGQ8QfiCRSHTaQObu9fAB775nW/JrxRBLoKIoMNJ49Mm4rCVxroLSzQ9BQkP7CMFOZ5u5JaSMajZed1hasU9itV67pYZEu4Ie0XlKWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1+CxZYS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1+CxZYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2161F000E9;
	Sun,  5 Jul 2026 16:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783269706;
	bh=zTR5aBYypRAxn3IWxX1LzzjHMom6iKOtcbFbMhSvXDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D1+CxZYSq7FAHrzHIT+3V0+3ncYmqC4SXD2F/7GGdBQh9PuY1hfFaOw3sMHpw84pc
	 nBXEjCjz8i20YpvuaurO6mtEtmm7frKjv6H0PGzxpAORPi35M5azWqsEpx4qjkyV8B
	 U+1wrLDys5PpGUZ3bd5CASdnPNT+4uHO9rcIUcqe8wLzB7q7S6y0larJqlR1Q+JE/V
	 h7HWZS8HviT+8+qog5jiogcCuAHbSi21qV/t8qEypX/LoPLX/NVXzVrsjOWlLaRFog
	 wWmWv0zIeDQTRfsgYO2P9KG7ZsuIdh0zfjqc/7FSVCs7ClMHBTIHKurepCwC/7D9jO
	 pw1ce/ygdNbww==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 8/8] mm/damon/sysfs: remove region size validation
Date: Sun,  5 Jul 2026 09:41:42 -0700
Message-ID: <20260705164142.101865-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705160559.900E61F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 05 Jul 2026 16:05:59 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Removal of region size validation allows accepting negative size regions which are then silently transformed into valid positive size regions.

No issue.  Read my reply to Sashiko comment for patch 7 for more details.


Thanks,
SJ

[...]
