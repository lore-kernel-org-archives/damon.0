Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69C3196C7C
	for <damon@lists.linux.dev>; Sat,  4 Jul 2026 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783193777; cv=none; b=HAEFkxMixBtV7RCOGyo5/IywSs35wT2eX9mRRjBvK0FKetLcD2JijRleMw+CUGOT2j9JFzLzvWl00lrCyd18fc0uBCpA59qru4HjTHHv0qdhyxnMrqDwvzoDvJbhPO1NCvVx8wIREWiBnmhVdipEyIc66LgaGAzfARcgYwq8kQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783193777; c=relaxed/simple;
	bh=SOoLC4dk0YuV1OJMRFIjAPpoRgvxJsxlrZOBOKRUL2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpVphiNjhDv+WwwhW2ZgoUwhi4trCgK92sV6vGcrAIAK+em2eCy1LN5cNdQ0KzYGKwkQJgwW+ByxhfDstPQadGpeJ1itdSQxULinPAfAxxaqgoEP9+l27mTIJqxSo1RZIEc/W0lngDrlsf59Ki151+AUapp9v5CPl5Edsfc7Lkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfBzf98q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfBzf98q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EB31F000E9;
	Sat,  4 Jul 2026 19:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783193776;
	bh=SOoLC4dk0YuV1OJMRFIjAPpoRgvxJsxlrZOBOKRUL2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dfBzf98qkYGFZgOHW+BKm1n9BqD2EijvVxcoPNkxc2p5BHm+vef2O+0pxp21TAHa6
	 dcGwVpbzY3jRdFGXC6f0SYhb7UAlbjys7njvs6uSU8tbkayy4YeEWQf11P8fOM7pCe
	 VC8XoD91oo7I9Hpu6sZi16MAZzqaZeRC6tYIVANzw27ZRg6VoT1m8clrpFF5W9s6A9
	 HHxFAY8jE7/iTIrD2RQrNPxA4sHfGBphfqWTGudo4QU9gthsBcqm1/lVjpW3SBLUEU
	 ApWrTxegzxjVKxfCwPgetnTZKFzmgadJ83fcVUeaVPhS82AEgIakeQlJudR4C1e2/F
	 A/Jz8dwGnUL8w==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 07/11] mm/damon/core: change damon_stop() return type to void
Date: Sat,  4 Jul 2026 12:36:13 -0700
Message-ID: <20260704193614.1224-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260704182324.47FE81F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 04 Jul 2026 18:23:23 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] ABBA deadlock in the error handling path of `damon_start()` when a context fails to start.

I will fix damon_start() patch in the next revision.


Thanks,
SJ

[...]
