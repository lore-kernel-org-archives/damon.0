Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBAF3AE707
	for <damon@lists.linux.dev>; Tue, 29 Sep 2026 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669004; cv=none; b=aA2PKD1b7d2hj9DtS7nsuasogWFh62NZjufCWjPbAckXsu8MZ5vFVdh8ToAW4oaTSHbzj+o3xAyNRUQ8lgGzC5s70wvNBbDhgGPkrHjpStL9q8EMfRaCAbUBClIHWxIBdAlsoi00gfYDtQQao1bJXKx/D1rdbcjcOS5dc1Im8WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669004; c=relaxed/simple;
	bh=Ha6wwrS73MQE2YfLl5sCyayUqtAc53yNjK42aGRjZH4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JDhhY6EEtLT8jTorKyn7F1dArceqamHT1wlV3hIjh/BvW6+UlLhQABsBwH+3w46klKUu+eeXx7dehIpgqXLdSru5VnARTGNesi96GMWF7Ksez98sO0wM3WrfaLdpFH9lckyhpHzp9AnfQEpGR+uzIM3jm+6IqLuhYHeS9+slfaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o15PEgU9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o15PEgU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99551F000FF;
	Tue, 29 Sep 2026 08:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790669002;
	bh=Ha6wwrS73MQE2YfLl5sCyayUqtAc53yNjK42aGRjZH4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o15PEgU9duhTMY+zF3kYt+2iWD8IOg3qeZyW2LvtP1phmR2mm1+N2zmCH9UBBjiqD
	 SlhbGw3bXoXlfFRSFAM1by0POyUczZOUVFRAkqxK2eX1AWRzb9YwiNjGMFqOCc4piN
	 3cmSDrMeloaxJWRt543h9tzCbrwLb3XBDj9hC73uwZ9Nds2TOZGcMgYrjZRjrio2i5
	 u7Nu8w8tKjPOUiK/nfwSp8fZTlwwgh7gu2xHPQa+n+CcTV0YO/NRusWqNhzZUDQ2+4
	 b+nl+uI42zmzNVQsyqkOU5ofA0CgNfd5va/pzeIoXh67TfmmlGApZURbEGVUFsEB3R
	 iBg828h4UsjCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] Docs/ABI/damon: update for quota goal metric
 complement sysfs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260929080113.41708-9-sj@kernel.org>
References: <20260929080113.41708-1-sj@kernel.org>
 <20260929080113.41708-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 08:03:22 +0000
Message-Id: <20260929080322.A99551F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON ABI document for the newly added damos quota goal metric
> complement sysfs file.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929080113.4170=
8-1-sj@kernel.org?part=3D8

