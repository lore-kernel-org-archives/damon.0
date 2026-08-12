Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0BA33D4F0
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 07:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518145; cv=none; b=bjf5prW+30bV9HbggL3QVua48ZFloRwHNA277Sp4MP4g3T6fp3GgtCcqwoH/ru6FdQu9kUwNqI9WXImCBIb5gD3MuGushmU5G8p8FnwM+5VUClxrtGS6NaffXMieiyRHdqWZFeWyAhx7/NZmURLW3US/WDW0N/o3hcxvGSnmwSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518145; c=relaxed/simple;
	bh=LWs5PPgFw1TWjFnObdi2nBFk/RSvRrQviyGTDSCsTdk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZoToXdTT/qV8FXsIwftYKNBqXJKF6KH1CoZ4K/RqArtvv7aUbebaXIFCG4oX07430+siLbgPJxxhq398NWNCgRnv8hPFd+p+7J59iw/oeRb1Gn6FZHlgLWa43resG/CffvQ15XXA7LTzSZ+V9xKD82TXLxwZZahDHCZyAJB+KCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0HXh1uF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0HXh1uF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50401F000E9;
	Wed, 12 Aug 2026 07:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786518144;
	bh=LWs5PPgFw1TWjFnObdi2nBFk/RSvRrQviyGTDSCsTdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e0HXh1uF8NGXWXPNc2gxPWV8cjE59/efFEFpvG3A+7taFmJHw2o9LN8Y/8/R176jm
	 NvT0OLn1XaE0mnJ+v7KXU/wwzKdfQryS33HBUKxi10KSDjrstritpBSvjK0AiYe1a/
	 JBH9KEMeczpjYy9TxbPDhDwGpLMPWvZ0x5qm9AoN1x36dTn/xfZWfmjT54VqyF2rh/
	 E3pqI7WCpD3fcv6It1CbkLGBxgFUdp0XZKCn12bWlJ3Jt/RJnNerLRX4gGHFDA/Mom
	 he7LUYmHJiU9aoJWeJCR29COrX74kurbYIAt4nfW/1VIISVmRbylwrhq2GWtGoFe3W
	 L63rl2LTjySMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/7] docs/zh_CN: update DAMON design translation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Doehyun Baek" <doehyunbaek@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260812065914.3071433-2-doehyunbaek@gmail.com>
References: <20260812065914.3071433-1-doehyunbaek@gmail.com>
 <20260812065914.3071433-2-doehyunbaek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 07:02:23 +0000
Message-Id: <20260812070223.E50401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update the Chinese translation of .../mm/damon/design.rst.
>=20
> Update the translation through commit c24a7f497cb5
> ("Docs/mm/damon/design: update for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP").
>=20
> Signed-off-by: Doehyun Baek <doehyunbaek@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812065914.3071=
433-1-doehyunbaek@gmail.com?part=3D1

