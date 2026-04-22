Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D69135898
	for <damon@lists.linux.dev>; Wed, 22 Apr 2026 21:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776891742; cv=none; b=WKswy4Zwo/vZMF7HJMTDdSB5BggO2UpUL8bo9Uh/jAwvdR5PrCH2uscEw3tfXPOWtKcrlEVrLRuzzalGfBPH1jhhxbpIIGixI5O+Me7VnUJx8CLR3TbnHyOsuZPAu3Ir2UXxBzysRZuXDwiwkaGMmpalNTtftPWlwXPjswYhK20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776891742; c=relaxed/simple;
	bh=Xitijc5c38pKWwyBZvGVDS8Cbhg9oBYH8PH+xIvDMA4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dM4vtI1qyxl+iuvgE0QkLroyvuFEXfuBte4uRxXAVfZcd/hhxghRcrvmiehZf2MaHCwmWaQGljZIynFupcGmS+Q8Wb6betlwXV6VuYISBXsSydt+lIDlcISZSUGqAVjRubtLtS7W3DXoQhHtJM7959V8WkN+uZKb8tIMycERvP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkpvQG40; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkpvQG40"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A666EC19425;
	Wed, 22 Apr 2026 21:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776891741;
	bh=Xitijc5c38pKWwyBZvGVDS8Cbhg9oBYH8PH+xIvDMA4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dkpvQG40E7Au9iArn9ewph+xCXD0hDmFGEY6iZui5YRFH9rOSgjy5L9/65PKzoZak
	 MrX12iWlfPRrIvbTkRmHrK5o7PDgUHdtpIREDD3V66gnho2Q87RU8Bs6l2G4ZS1Eq4
	 +BKS3gtidVXqcFf9ykLcBTBifJS+V+KrDE7qpIN0UnrG0sPGR9clIq2Tj/bnElEwjG
	 PwMHBzraEMciMEx81H+tUmFx5Wpb91BRNrC1642I/+ujwleZA6Skkl6SPkxzZ+MYzy
	 Vj4RD/gMDgT2Wvy/yAnNsWAggMI0A0EKP+au9I0AFL6WuJl8BJrkCNRhfgralB3CBA
	 LKlf/gYj7GmGA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/2] mm/damon/sysfs-schemes: protect path kfree()
 with damon_sysfs_lock
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260422143503.71357-3-sj@kernel.org>
References: <20260422143503.71357-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Apr 2026 21:02:21 +0000
Message-Id: <20260422210221.A666EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 1 potential issue(s):
- [Low] The commit message incorrectly references the `memcg_path` file ins=
tead of the `path` file.
--

commit 9335b00570732d12b29034fc72a20506fd69fbdd
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs-schemes: protect path kfree() with damon_sysfs_lock

This commit adds damon_sysfs_lock protection to the path attribute's sysfs =
show
and store functions. This prevents a use-after-free race condition during
concurrent user-driven reads and writes.

> damon_sysfs_quot_goal->path can be read and written by users, via DAMON
> sysfs memcg_path file.  It can also be indirectly read, for the

This isn't a bug, but the commit message references the memcg_path sysfs fi=
le.
Since the patch actually modifies path_show and path_store, which handle the
path attribute for quota goals, should this say "via DAMON sysfs path file"
instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260422143503.7135=
7-1-sj@kernel.org?part=3D2
