Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753D7348896
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136048; cv=none; b=Sq8VzezX3pnnk9UV2IXrRPuxqyJIJExw8LwSEiWH6By9HgflCHxdGbLGCjtI7IOVVLBgE5uW/SmAQXJIy8M3CKlUlJleMdMcLp4y9u5c5vIDIGTNKkScGw4jxS/744W6+Zp0smXfasIQ6BSlWX/HkhYSKn9+/YvubehtH3QFyAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136048; c=relaxed/simple;
	bh=3KFie3d3IegxBOR/gXNL9VBuJkn9RkDwjbeZ93FolXw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sD9vUVx0BvlHSoKh5vumn7i2OYmRcW59eFtxVAt40Yda/1jd5CQMawgfJQh0aFdqIoty/T6GKpsM8QZfb3rGa4TPX1n4p+xTyvQFpAVmnAn+ZEK7TumEsRsF8tXReRqIeR4fhhjk8j00nvqcFGANhmeH7XANeWFnTq+jWr91+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMWvWHsw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMWvWHsw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72961F008A2;
	Fri, 11 Sep 2026 14:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136046;
	bh=kuxmiETyYCUEw7ebNl1GSQNB6djycQ50gbdCfA+Heeo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PMWvWHswhdO5b2OXGu72ZjUCf2lqBJnBjJvEAEPrgtVrklpsbQpyG5rhoozanPKLw
	 jqmKdkRd3zt9inSqEVMeMNtwqfoyKH3cE4wngh2CgV+stx2anU3l2/Lf/w6bWtj4QV
	 SywimHwzxqHrK7bdqFaaFuPcJLg3f3rkeAacAVtPayoGTIFXD/TZQKWosbg58PvSfM
	 CJbck+XMJ/fVUz93LFaeiFVUIThfq4FpnqBOfbm5o2zMhhwvMAjFXFtgOyxlW7OETk
	 TSOwGwxk+WDwXNYWE9+QAjoSEM6YXcbYqze3rMw5Q4rjr+LJ+xN3d14HEvSmmIoA4i
	 a0yTfTM+r3qzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] mm/damon/sysfs-schemes: support probe_hits_wsum
 damos core filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260911135510.96914-6-sj@kernel.org>
References: <20260911135510.96914-1-sj@kernel.org>
 <20260911135510.96914-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:14:05 +0000
Message-Id: <20260911141405.E72961F008A2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Extend DAMON sysfs interface to support probe_hits_wsum input.  Also
> update sysfs input based scheme build logic to setup the min/max probe
> hits weighted sum range as user provided.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911135510.9691=
4-1-sj@kernel.org?part=3D5

