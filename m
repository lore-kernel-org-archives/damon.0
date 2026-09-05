Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CA434FF45
	for <damon@lists.linux.dev>; Sat,  5 Sep 2026 20:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788640383; cv=none; b=JXWxg2Z2yQW6PweBacLRPv5uwIzzrggrDpprjc2zfrN5t9xV+TFsEFMp0Qaymucc0nS42CB5qUw6lgwx2W7aiIJcfMKwWIXIT0vE6qo5RU6vs5sj337yrQLZ8d+zWrEDbh2FEpnTdZeeUtBow7ON9cyQkK2azzs0cGi6kkVIyZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788640383; c=relaxed/simple;
	bh=f8JDfulsb8vnO+yzit+NlDcYdMv8FhGaHpzxF2Szp6w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bgKD1rk+a8bOljNBjLtFGCHZOlrwFSIHnQ/ux71JB7QT4ZBDblhW6/nh128YIQceKG56KL/JCJTzlpKMJBZMlPVHaNcQSvzAYmUVmOPO385SDcjhh+1iQIlj8sp4f251YiBfkxu0E3dHRm2xhS37d07c+WmXdOXZikBOlnSWxb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfG7OauN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfG7OauN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804411F00A3A;
	Sat,  5 Sep 2026 20:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788640382;
	bh=0hFU6M85f0REL1EoH4TUVIQb5PUjRl6qYwuxpDFiDp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dfG7OauN8a8A+9PD/sic7FBkLn3sCSbIMwzuSw5s2vq7MbvZQYQ+6K2hOCSmBGug+
	 jx8aYs42Aqz86jw1sNLa9tNhlXw7cQLban21pES5b1sA81d6spLa7h3xeW9vXTWmtB
	 4fIH6Y1MQlbWvKTSzjhVss03bN7HcUmXqGi/j+iB/XHORn9vJ5ZHZlICsaux8HBgoo
	 AA/ot+z8YYlkJQDilu0p6qSdclTQbqcgDO4JN58l2rJPoWSofSfvak4odnB+O047QN
	 966ANfm2m64AMEONI5/rV3mbi7xuzYRsRmAv+OJr0/erpOqiyOrgEoPWOxywlk2PNG
	 RE3jv/KiH+iiw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/5] mm/damon/vaddr: support prep_probes
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260905202634.88102-2-sj@kernel.org>
References: <20260905202634.88102-1-sj@kernel.org>
 <20260905202634.88102-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 20:33:02 +0000
Message-Id: <20260905203302.804411F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON virtual address space operation set (vaddr) is not supporting
> prep_probes.  Add the support.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905202634.8810=
2-1-sj@kernel.org?part=3D1

