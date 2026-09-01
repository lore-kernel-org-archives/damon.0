Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978D42E975E
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269865; cv=none; b=QwUPJlzpSzcBhyNa51RK7SmcQa2+GpBOyNa2kIQEdElrsbhMvp9GgxLDduoVhbU7demTVGFB8D0AOvfdGNKrOQIqhCq1RCvj/TXB7ZzX4SUgqndLM5vaFU5lIWRyofFrNMSkCrLot+jEPEptXpSNJ9gwLiWpKtiEIMoPzuJCy1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269865; c=relaxed/simple;
	bh=dMQZTh2ULzb+MczGJH7APbIyLADXIUZkPMwdlzEWYAo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RY6Z7Bfed0K2RKUPthwyAhzttG70nOUXiixj388jLC64Dm8NZy0WyagAYssmGA37yoPXBaD0Z/HE8NmL++bY/lFhVh0BBIYfpgF1pvZgFD6w16zBx9vD19l2bUAQMRX6fYCks2+v7mivFAqunfBAj8YHGaLjIT+Tloa5xK172lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biwiqEDg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biwiqEDg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EB51F000E9;
	Tue,  1 Sep 2026 13:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269864;
	bh=LVqkGo89y58LW1OorGf+EKridhhcBsRYgMSxgeDNhTs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=biwiqEDgDebNiqqVTiPC33m1jhWPWf5TwUoN7e0vM48UszeZlmCIE3JuK1gtPLT+z
	 70mYMoevE27AbIV+93jgBsrlbl4hhCciOBsSLxYUSm1eQF5UUR77Vt1hh90W2cc919
	 0ag30qsfQ7uOZu3DOPH2YJBwqrIouL9jxXhdrkM5Vt6Vi4Le86oeRTGCZTX+4Jj7ZZ
	 a0X8Y2a4VfXAUIAAyAu2YtZwfkd2Khg14tyHZSCz//sCuDa9SVZ271+gMP+PefiSEg
	 3nDNmE5/sHSbfzQZuMdG6v4Zty/VPPtmtzMY0dZ4z2coqu9JOWEiR3zsT+klR3RT9Y
	 HCbYT2gsMqaIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1.1 11/17] mm/damon/sysfs: create directories for
 nr_preps writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901132506.99243-12-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
 <20260901132506.99243-12-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:37:43 +0000
Message-Id: <20260901133744.45EB51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Implement nr_preps write action to actually create subdirectories of the
> number.  Each of the directory will be evolved to represent each probe
> preparation action.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901132506.9924=
3-1-sj@kernel.org?part=3D11

