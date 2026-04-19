Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A75140DFC2
	for <damon@lists.linux.dev>; Sun, 19 Apr 2026 01:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776563530; cv=none; b=Df5HRkLgO8C1Bmv0q3uaruzYoxsSe4EdYCYxdjqO0DkAsljW6fcmDNxu0NK378DZA3+yYSPA4wT/exPs4nGe0DKjLaJvG7dsz1VBGqqJzvQqw5krKxv1dzfskJX/ClK42oW8fd/Ni5Eo2S/1IA9UlDYpZeMpbo8vrgS50BG8+eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776563530; c=relaxed/simple;
	bh=0qQTslq8Aa+XNzsGYllN5MCMiDFkeh95gidE05tSWjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKGnLcrI4ByB4vkUOCrZGstn6xtxkcyH8dHkhHfgYHqhIyvOun9GaZCu0LRCeSm7h/0FSQFZjfx8wveI/VG3GioFULWgiIV+lscYLv9/gw9tx+r48czfbevEJUjTf8zaZmIDOtuoE+vozpaZ9HC39ut7XpOsa01nmyou22Oo78E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaNabmCz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaNabmCz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06818C19424;
	Sun, 19 Apr 2026 01:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776563530;
	bh=0qQTslq8Aa+XNzsGYllN5MCMiDFkeh95gidE05tSWjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gaNabmCzJn4mAtJefpCaVGM6+fnj3kF5LwF1G1vImtUfk7CVc13lAR52g505wwtNR
	 dyeflNuMUXr74W99Y0X4Fx9yqxv2hgpeoaEa0lb70QqVnvS+mgeWrriP2QRqgbXDh9
	 2J6UyP7RGi8dMhCr7e14/jifgAQ/ds2386LjlJKrRUK+AsJSNl8f2mZk8S8W9Mw8gC
	 YrV2b43miQMp8PLQGcDVb9aZIMVX1EmRvwhEjMDavBsJMK8WxedgiPfxJSAFpFw601
	 2yYckzjPgN5f6S2O0jpxA0ka4CU2eZ7T75T45dvOQJAs7E8C4rOdq6YBJb9fm6TSip
	 cbJn8hmvrHRNw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.1 3/3] mm/damon/stat: detect and use fresh enabled value
Date: Sat, 18 Apr 2026 18:52:00 -0700
Message-ID: <20260419015200.1120-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260418235155.A4953C19424@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 18 Apr 2026 23:51:55 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 1 potential issue(s):
> - [High] Bypassing damon_stat_stop() and overwriting damon_stat_context causes a memory leak when explicitly disabling or restarting a kdamond thread that stopped internally.

That's wrong.  Refer to my previous reply [1] for more details.

[1] https://lore.kernel.org/20260417000308.58975-1-sj@kernel.org


Thanks,
SJ

[...]
