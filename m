Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD2F3A9612;
	Wed,  2 Sep 2026 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346993; cv=none; b=Tj059sH+pdKSHcmBpcqMP9sDD14aZDojQaCdckYPGko/Nv/XsZh+Q5VQuje7EmNeU9Hat6H8r6bXWrQqpw57k+E9F8mjizFru71L8stJtHT69KRNB9Eiyc/OUMpnEJ0/h5ZEgnaRS28YIT5ttwz2k7s9ZAjkHKS0LkDozNWv6UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346993; c=relaxed/simple;
	bh=1hwkSGbuj2IaG08oRyEnwalYZYTJwh47DjvQXN2CSaM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EFkAWpabrgi7HEwWwwm+d2gxeRFxUrZHR+RMW+f5D7q/ubmKlGupXYSa65BW+ncFPil45kjWv9Rnk7JyDjwB3ua4JfRGEZiPKzVrvQpRn15nuCH99zrflDee9nj6/9ExRIW577eCEXiyP3UsZjkem122BU/bdwVVQkSwRBZCQcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRB6qxFL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRB6qxFL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B2F1F000E9;
	Wed,  2 Sep 2026 11:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788346991;
	bh=1hwkSGbuj2IaG08oRyEnwalYZYTJwh47DjvQXN2CSaM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VRB6qxFLlQI9ZT+2j6nIFZC2pBfW+Cdxt3dzPfT9KvUCbDW2/ecrA1KIEoYrrDZuG
	 Ry+2agGkNCxXE+X55xBFLcdMP0y+Owvnz36SWbMt7sRxxIt6a8pyZ0cNH2+5IxHwzr
	 wBc5VN5hci3aTGSHkGujVulXNaxRi6lvhygI/cC+bbnFaxFHeRQIo38lQraqTtfyfP
	 f3OigdofXEmq8yIjmWAAvC69qITL/miMM4XnJCezVGHt/hGwgqG0k21eUhV9YQyO2c
	 NXfRoCRoZ5KrI/0dViZm5HDf6Y87Mk4ARQZocOF2bvbuIivizWpSADglqy0uuj6ncf
	 kxF9VU+bqO6yA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 07/11] mm/migrate: add migrate_lru_folios() entry
 point
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: "Anna Schumaker" <anna@kernel.org>, damon@lists.linux.dev, kvm@vger.kernel.org, linux-cxl@vger.kernel.org, "Jeff
 Layton" <jlayton@kernel.org>, "Chuck Lever" <cel@kernel.org>, dsterba@suse.cz
In-Reply-To: <20260902-migrate-refactor-shivank-v1-7-9dcca87669c4@amd.com>
References: <20260902-migrate-refactor-shivank-v1-0-9dcca87669c4@amd.com>
 <20260902-migrate-refactor-shivank-v1-7-9dcca87669c4@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 11:03:11 +0000
Message-Id: <20260902110311.71B2F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> migrate_pages() currently handles the asynchronous and synchronous LRU
> paths separately and retries split folios itself.
>=20
> Move this logic into migrate_lru_folios(), leaving migrate_pages() to
> dispatch hugetlb, movable_ops, and LRU folios through their respective
> entry points.
>=20
> Keep the existing retry and accounting behavior unchanged.
>=20
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-migrate-re=
factor-shivank-v1-0-9dcca87669c4@amd.com?part=3D7

