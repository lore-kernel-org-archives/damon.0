Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ABF40D569
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 00:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781828599; cv=none; b=UuqOQb1f4RM2/EWnkqc+pPNNKnFWIH2whw1n3F+D3U1mk46SrxkT0x+spDoNqvZo6Jgw+11urir0Eg4KJL+5zmhpAXdRPOF3vlQ5SzCRogRZug0JrmKJ74Bubyx9QNWV+U3+QCLgn9JBLg4yuo3hAICqcKVUqAw6sJCjUZ3s76Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781828599; c=relaxed/simple;
	bh=OQkGq2B0tBG2xfxZH8uxkUPcST3OzOpREBNyCQQ8eLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MF58nLXuQTRJLPnjU6uaiD+/w0JwmAcx3foS4M6v3onedTESPO3LkEbGqJbSqrm56lpCH+Slhq1Zx8MvhUJ9eyq2rK5W0UaNH5XcSMoqtQYSuKJj4s7PFFUslvJ8zRCHt/4L1ocoOLaeXoUdR7cLoz6rvo3XgvZPPYgYTAqEbJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPc1xhz9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPc1xhz9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E731F000E9;
	Fri, 19 Jun 2026 00:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781828598;
	bh=pcFHmze1SJL+nntiCV1vA4CjTt7d3bh7wlLpANJqUJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HPc1xhz9pJBpPLqQQjsOpyN82X4IO4mvGiJECfPtu6Awsp3kCnNkqR7xoTEnql1w1
	 k1B8uoIrzQZ805A1aX9tJe2wibgoWgMMqQk39s6qK+WcKlUVuYdX4poAhFyd2dAZVH
	 XyCOqoogq31+5gXuGPj2l1TnUw176nwG5ZdiLMeVxCxDMawEAKK7rK1lLD0Vdfr/ur
	 ne0HP6mbUN5rhgQSOH0Rl7Z1YWkdEYHmSbEM/wQErZEMiJR3IR7Dr94OZ6d79VKnSY
	 loKZ/c3YABLqWQJHPJbrA+2vRxLy1dALrFSfUYPunZsfsi46nJX1OjztfOSumeCs9U
	 4WaX2rQSwuzbw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 09/11] mm/damon/sysfs: kobject_del() probe filter dirs
Date: Thu, 18 Jun 2026 17:23:09 -0700
Message-ID: <20260619002309.8518-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618153451.1E7171F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 18 Jun 2026 15:34:50 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Medium] Missing `kobject_del()` call in `damos_sysfs_region_add_dirs()` error path causes delayed sysfs directory removal and subsequent `-EEXIST` name conflicts.
> - [Medium] Missing `kobject_del()` in `damos_sysfs_probes_rm_dirs()` leaves child probe directories lingering in sysfs on error paths.

Both are wrong.  Since users cannot arbitrarily add/remove probe dirs without
it's parent, and because the parent is patched too call kobject_del(), probe
directories don't  need to be kobject_del()-ed.


Thanks,
SJ

[...]
