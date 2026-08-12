Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FCA2A1BF
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 07:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518181; cv=none; b=t5nIkCJAbjrjYybG0QNzWdElUQ9x399pCSOKvIBtyQ6/FZ/2R+YpfoBoc/D4YBJQbL/zib4wX3xobKPXrWu852BJBjW0+ty8jR0M4m3dgpLzkeRWzOyYY3iRpq88t19X+TXGUtXc8554MZtU+JrMjIRV1FRKntL2KQ0JtCt2xHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518181; c=relaxed/simple;
	bh=RvYscFJ33+LTFY6FZ2f5GzH4H7mpn+iNB4vwtVKobqA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lMq9ei8gw60wphXwaqn4GkVAygyphvxgDY1ltS3LnRy/Qb2maEuB5n1Ha1XRuHNr9QZ5eg+1RVbsWrEZiwzmLXSnTFFb8ULPkfXUbtWYeeImxJYT4dcunqe4nS/VPPj14aH/jU8LM515Xe0MHy8HKvHacQqeIh2RffGtnGX8OP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYtx0dRz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYtx0dRz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2431F000E9;
	Wed, 12 Aug 2026 07:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786518180;
	bh=RvYscFJ33+LTFY6FZ2f5GzH4H7mpn+iNB4vwtVKobqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IYtx0dRzdezorO05/7XeE8uwujHmMc1O5DUNMITtEVxpptBujZFVqUE+uHEnCKNV2
	 C9VfnYPnxIMFMMx6AFq+zxDqH518PC/bRJg+JJkHHO+IKQS1wBciT+isCYe/MgdHxz
	 7xMCfDcRzF3D34W9YRuf9pLmUlUO+TkAUVKy3P0xwGgn7PmE0/xa1hCWhBYmHV41eB
	 Er6DfWFFOyHK9p+XK9dHWad6nPTYZtBbyilWTAzZcveVeh21v/vRdTShHZ8TvcSngw
	 YKs5e2F5qLGBubX9H3RvwLRnn7HvcijPlVkddt/cKxpZIdW0+Em4/GV6h3HoHAaQmN
	 rlSGLo50ycRHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/7] docs/zh_CN: update DAMON usage translation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Doehyun Baek" <doehyunbaek@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260812065914.3071433-6-doehyunbaek@gmail.com>
References: <20260812065914.3071433-1-doehyunbaek@gmail.com>
 <20260812065914.3071433-6-doehyunbaek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 07:02:59 +0000
Message-Id: <20260812070300.5F2431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update the Chinese translation of .../admin-guide/mm/damon/usage.rst.
>=20
> Update the translation through commit c9380cdd949d
> ("Docs/{admin-guide,mm}/damon: fix DAMON documentation details").
>=20
> Signed-off-by: Doehyun Baek <doehyunbaek@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812065914.3071=
433-1-doehyunbaek@gmail.com?part=3D5

