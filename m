Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF0330AABE
	for <damon@lists.linux.dev>; Sat, 25 Jul 2026 22:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785016849; cv=none; b=bRJKvap+UAJcZ8PtI9pjyxX9vQ4D04cbagMz80izY9L8X2KPEx1aZTEUpN5UPM0BCOUIdI7J/pTceCe3gDqqOyQr3ltEBKD2AOKEllRYk3FS1XxJTaJXTDDFWvdOredd6Zyhtmkj+0gadIcFGRd1fDUe6nUp36Xitk7Qu3OOMrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785016849; c=relaxed/simple;
	bh=ZcDuR88U4PIulrSJoxna6nmLC/g776lode/HG6e3S8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kENeDWvswe3tXV0RhNlz9JUEK44pzNfM/MQUFyObFjHklDWpHtpVlMeaYqmZUgfJ2DZ1URLJcPSfFe0gPyq/b8VPFXI2czsKS6K2XjIN0EAyQvzVTGr+qXLkGIvpHuTA3SSu32wNazsudBL+Y3GlowY9WtEwubDdErSHoY+Q5Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cR7/hUZ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cR7/hUZ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6711F00A3A;
	Sat, 25 Jul 2026 22:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785016848;
	bh=YbrI4fJLJ8F87p51wVWUS3gAgIf+YsCwrVfnMpPxLe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cR7/hUZ5bEUrWLOVq6L96BmR7PV7Ocbbiioxa8/+/znFtAn6UW13ECsioW35t/kAm
	 i87jj0LIYY+7l2zqu1s8OwhSRO+eNKwSOVIvaFnc9NdDqPbV6NGJQpQZ6PYmPyKKz1
	 M06UDi8jV1q9P9DhI9ilsTCvQoGaZ1uO9iko4+UYyU28ZqGt7jpgUgZztWsRZ19yBv
	 lTIxM1P9rdzKfmw/wqjy7FlbRzLA4dt5FJdQpkHcAkm8DLCKOg1mkLdmDev2/j22OE
	 3xP0GvfwMZp3wZW8CbkJx0X7JtYR4Jmp3QyiwrFshXr1s6smcOdvJzFyREIQ/WciNQ
	 QTKPzu8YH6ipg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 15/17] Docs/mm/damon/design: document probe preps
Date: Sat, 25 Jul 2026 15:00:39 -0700
Message-ID: <20260725220041.136780-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725210656.A896E1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 25 Jul 2026 21:06:56 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Typo in the commit message: 'DAMN' instead of 'DAMON'.
> --
> 
> --- Patch [15]: [RFC PATCH 15/17] Docs/mm/damon/design: document probe preps ---
> commit 8a47d1109fc79c6ddb959763fb0ede38e076501a
> Author: SJ Park <sj@kernel.org>
> 
> Docs/mm/damon/design: document probe preps
> 
> This commit updates the DAMON design document to include information about
> the newly added probe preps feature.
> 
> > Update DAMON design document for the newly added DAMN probe preps
> > feature.
> 
> [Severity: Low]
> This isn't a bug, but there is a typo in the commit message body ("DAMN" 
> instead of "DAMON").

Good catch, I will fix.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260725210225.129944-1-sj@kernel.org?part=15


Thanks,
SJ
