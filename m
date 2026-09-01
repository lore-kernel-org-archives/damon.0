Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3F93D994
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269886; cv=none; b=P8TUIKvAeXlB4y8RdunkN0LUIX8TuGLXp/YbCZzTLCFN9ew22DVq0Lsux4GZ0Cx/zdUdyqcFKe66mYmqDNhWBw6Fy2SLkJ6HRbj352WJBnyIPS5EVUJUT5+UvLB4mYPuBU5TW5vD+LBe6QHLYDNBotQZ+GsaMuLfFHiL/eJqP6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269886; c=relaxed/simple;
	bh=Bx/6N0y8mPwjK+j55Id3DdU+W9NhfuaA6/msOABzF70=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MtwbHl6VxDSZfwV1oItn4KVASlqOCnA8UyF8WsJz87+gmIFFbduwj/3u2ByBzQRaLvAKCSbZd2pz4d6yX4nGFw3gSQ7N67zhExXIJuZdBXDcJG43kXnE7j8fZt7rwTwQilz6D2ajLoJEmmJuVoTkUcaSgdCYRWWIE/ibPKPXTyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUCLfD24; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUCLfD24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1A81F000E9;
	Tue,  1 Sep 2026 13:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269885;
	bh=Bx/6N0y8mPwjK+j55Id3DdU+W9NhfuaA6/msOABzF70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cUCLfD24cuDwiTzk0o5Mvq5sUUGggMcBgfkjfr3NtixI7AjXvmNCUDW6nh50/Q60D
	 OClCexkiNNtXyNuXunO47NQ55nYey/Mitn9RNebluZusyVrylLx3QqwK5S1Hfwlhv4
	 q4YemkNtyaQwA4fONP8hN/2aKpU2MOP4Kr1i73cMUcB5KNcYCAUpeOdzERZF8tCEJL
	 rW+MuCfJWFoRO7nPpdt5oIH+rxb2V1gZL6nK38nw2aFUue2ZeGSnaATuQEhymUWTZY
	 /srhM979BOJCZlZ95NJ5vPfYTJuw/LuhMPIN4qrPJpzLm2DkXw2AoM0E4fjIsMnqvf
	 EXa4WynLfDx4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1.1 17/17] Docs/ABI/damon: document probe prep sysfs
 files
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901132506.99243-18-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
 <20260901132506.99243-18-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:38:04 +0000
Message-Id: <20260901133804.EB1A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON ABI document for the newly added DAMON probe prep sysfs
> files.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901132506.9924=
3-1-sj@kernel.org?part=3D17

