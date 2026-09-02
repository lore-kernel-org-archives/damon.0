Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080EE30D407
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 05:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328568; cv=none; b=bF4iC551KNVTpDBc5umeywRh3HCst28G9FVSzpbWcvb4QtpCjvOEscJm3Vo3IjGuAKnxDgScZt538b+FtokogvDObn99hBDHIXcKWQdqWwwuiZI0LLXoQbJ1gk69qsHb2icaUFHu8SYBuMe0nQw9ccWjozpwidHhkG1G+ZOCnZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328568; c=relaxed/simple;
	bh=xY/6A2ZJzvEE9WpLoLBI090en0gM5h3l6Yd1Nr97d7o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tji1YZNnwk6KvlUx/YHbNwuZYkshgRGadXoA5ojqGF2V8srNaLs0v8H4bO2BA4G+CfwhQsI+vLtur5wQCQfrWdohu9mcyovfgKj/m9CphIknF/sm4rfCES2jpdfHnGCJXhUrGHt44TewDe0YvqAwPkSXQVCHGCzKS2JkdsEK3Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEUdOnj+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEUdOnj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9947D1F000E9;
	Wed,  2 Sep 2026 05:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328566;
	bh=wWXFGGawxKW56iDw2Z4A8VOjqIsk3BotZkiJdxHXMUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BEUdOnj+g7Ys7vIXMaV/bJUoCD+zEkwSLAhMe45rtkjL2KjnexNzlfsYUPOCHVYmE
	 tGrjI/5rKVVB4C8qip0+WnHrISq8aa4gwfT8Pl9Ldt/bS2v/eO+wA+UuIxEalkY324
	 39nXn3pnINwtpIoO+2xvVJIBnc32qQNXSSCDm6yPD2xd/JvivNMDwk8LwVi2/C0JdM
	 bJJp5I7Aq6S8nwo38XlmijTCK/TcxCttox7fnT3d8eX4DDFDNsP/TqWeQz48V7sISd
	 p7BU8GTBBc75qPjCskbSAZyI55EqpwrXB97L2UF9eMyXYlnrA6zwyqtseKLZSBwmtO
	 jvQrsGhwHrJWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/12] mm/damon/tests/core-kunit: test overlapping
 ranges for set_regions()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902054747.99370-9-sj@kernel.org>
References: <20260902054747.99370-1-sj@kernel.org>
 <20260902054747.99370-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 05:56:06 +0000
Message-Id: <20260902055606.9947D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Commit 954157679ec3 ("mm/damon/core: disallow overlapping input ranges
> for damon_set_regions()") disallowed passing overlapping input ranges to
> damon_set_regions().  Add a kunit test case for the overlapping input.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902054747.9937=
0-1-sj@kernel.org?part=3D8

