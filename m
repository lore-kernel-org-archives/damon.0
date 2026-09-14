Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F4D48A8C5
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789399585; cv=none; b=UMqp55BOX5F9P34UaefJFbm+IELjtydfdto6AYLJ7ppSPy1uSxewwjME7WVHgiIkka03lgOzQpZ1/ldILArQAMriOYnY5+KQh9ei4E2HZZWhT4uvsKgRxIDJtYvi1SFjM78TGKETSvsdnyXyX7C6rLZBV1hL4D8TDTbJ3DuwHcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789399585; c=relaxed/simple;
	bh=X0AuZ/G5TYWHNtjjM88IBw1UoDSa7WFapQpydOCrLq4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wg6xTj3zEYyEM9o/0HcgNMhm+h6xvR9aFdeaigr25zpIVwowduoq7nbI8mdvgxnudr/wymJtWpIB0dFH+60LclaBHpdECG7bNd86hxNxTOxXjWvvsc+DvmQgWzrq4/vothk9C6FXGvOnSgelk2Vp8ctSMNQh8t1/KAo5HFt579Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISNjeebL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISNjeebL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DA11F000FF;
	Mon, 14 Sep 2026 15:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789399583;
	bh=1RW3P5hF6hQXPruvw2C0IeTW3T4388kb5BOt/LkTHkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ISNjeebLRnRA/bQMAWOMCcU/dkWbcMLTJhfSMB4/bx200t+zNjw9x2CLIkZm3otrc
	 /93/nMQs7/C0+ofj7lCROYsoN9m/pFVQOaH+5tq/37akJMV+Oi3XbU2mbzyaZjgkqq
	 jlHwYuqkIArPB2D1bpyLNrjEolP0yZvOo3rFoh2y0Z145vmly75Ih/yshEiP+3PlEW
	 A0tr16hHRc1PlZZYuDduxZtHXp/WE4ti9qQQOetPg/0nahazpDv+Ss7NUk+VU6vvKQ
	 GBWCJ0HLBSvZ+pFsalr66kaLq6ZkcB4L7hXhsZYiVqMtzwbDBeKFcCb9NaaO8U7BjM
	 +x75LkIv8UR3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] mm/damon/sysfs-schemes: drop centralized filter
 range arg validations
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260914142327.92510-6-sj@kernel.org>
References: <20260914142327.92510-1-sj@kernel.org>
 <20260914142327.92510-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 15:26:23 +0000
Message-Id: <20260914152623.85DA11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON sysfs interface is validating wrong range arguments for DAMOS
> filters.  Now the core layer is doing the same validation.  Drop the
> duplicated validation in DAMON sysfs interface.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914142327.9251=
0-1-sj@kernel.org?part=3D5

