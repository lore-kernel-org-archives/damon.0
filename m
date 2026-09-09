Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E5A54A7E7
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963714; cv=none; b=QoQIYwAcG/So7FYqItV07yybwrTFgeN1fNALQ12S7ZGx2usoSnli0FojeBFgrpWYul8VxiKc8QYKZX6L362K2PLf71qoaHE/9A37IqFYCxCMk6bGiotoAxEzwModkvxW0jGBe+hic3ZkLKV53VUe78cD3VDMSNEghIzmH9bhZx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963714; c=relaxed/simple;
	bh=5uEz1ZEgnyPUnqpxzseBYUyLu9KHE5AjAG6DeHi4L8k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PwYvp7Yfa2UC4895AVTdih2JcJDqV5zUrVSOGubspqDBlXV5m9y2NZtPYGHPATRKcCBZ8whohmo7omXUA020fOTzE3/g6tXz1493DA/RStf9CyP+qfrIzXn4SCeS4fn4hHvFUvtl5I6k7dPW3KJLhtsym5fXC346Aab3c3WHwHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enFd7nq0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enFd7nq0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1630E1F00A3A;
	Wed,  9 Sep 2026 14:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963713;
	bh=iWd+/MQgqmZcWWOLmvmGSFR/RzEW3CIRF8D9OSxbVMk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=enFd7nq0+cFP56GhRCmKpU3Dk5mR5oeUvHSg7uawG2gtlR64xR84CZubQ5GPwmeY2
	 5OkgSo+QHfdJh5qLD0N58O+V0qBj2JPsfkWlcK9vABQ4QoSo3u7js/j/tU4E68jrUO
	 rT3F0u/xd7kvrS8/XU+aCHGt9oy8kKKn4B2pMTYOzlM2d5eDcqAVgcNdsOnqIe+qL5
	 wQOFp6xdyL0Vr7edS8Z+i2G46p17Ae+caeZ+HNm69lvDleBCHV4fgO4PDlOt36+wbI
	 kQYDvf1wn/c/bL/7IfdzQLO+RopJHeGlyDPmTFQJSmFqCh+LE6ZoXQheqNiwUVbWJd
	 ut49YjWMNVekw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH REPOST 5/5] mm/damon/vaddr: support pgidle_unset probe
 filter type
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909140408.104699-6-sj@kernel.org>
References: <20260909140408.104699-1-sj@kernel.org>
 <20260909140408.104699-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:21:52 +0000
Message-Id: <20260909142153.1630E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON virtual address space operation set (vaddr) does not support
> pgidle_unset probe filter type.  Add the support.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909140408.1046=
99-1-sj@kernel.org?part=3D5

