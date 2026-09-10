Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE86490BED
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051669; cv=none; b=EQ5iyMO8/gdRGSZgTeSKmITgUmcua/2P43oEnQ0LDa5FB6vVl8O9QEdVb797871GVxSfPRz95/zV9b1aDaJgAhopeMif1thrcc5iym4uDOqZN0bBvHxO7nX3NqdLg6kEcXoywbgQPxgmEP3C9TRpoa+kv4NnsjvIGOot7E6eYp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051669; c=relaxed/simple;
	bh=R7I9aYjbmKTqOqxmAuDoqlu7uFPTXhqQnJCNrQ8utlg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FlgyU3w9ihLsUPZ+4sxMQi15egnUlF+qVQJCQhy1X/wA5pQVWpwSsLirfbKj4KwAzlcQEMUZNnQYiIdkZNz+Glgof7X8rUiZp8vyuFzYo6pAkYkm/tisEdBPHWNFx617Tbr6mPAvmaBlUdwFh51WQvZf0AIoJpQvl0CxVm660W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0k3dJUq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0k3dJUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6956A1F000FF;
	Thu, 10 Sep 2026 14:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051667;
	bh=R7I9aYjbmKTqOqxmAuDoqlu7uFPTXhqQnJCNrQ8utlg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F0k3dJUqJqBRaaZb8HM3OGZTz7J5s5ER3mANuS/QNyj4tZKGGUxRiF80bFngyN/c7
	 Lwpy+GGl6UDPRZZ4apezdRpQSoKO7QRtpPMQZjwMS+c1qR7TOzMQsHiu/JK5INUfk9
	 /2CScE6zFPWiMkBbQKrKWl0tjz5w2PXr+sF7en1PwEXzZi/qdhY/9d2aIC1mgCWFXr
	 YYtB+YoTtXLGEx7LJc57kqZfhEX/PGiiY5eNVI4ScAfpHlKJZ0R6UxvJyJSUQvql2J
	 QMfrG8SLS6+2qa9KC/ACP0+GBins6U1QqznnvVlowJQBOA6SfQQxFAs5/O1xZoQDGH
	 6UR6/OtdmTTlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] mm/damon/vaddr: support
 DAMON_FILTER_TYPE_PGIDLE_SET
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910142234.171562-4-sj@kernel.org>
References: <20260910142234.171562-1-sj@kernel.org>
 <20260910142234.171562-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 14:47:46 +0000
Message-Id: <20260910144747.6956A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Implement DAMON_FILTER_TYPE_PGIDLE_SET support on the virtual address
> space DAMON operation set (vaddr).
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910142234.1715=
62-1-sj@kernel.org?part=3D3

