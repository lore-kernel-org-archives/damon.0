Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F8D49158C
	for <damon@lists.linux.dev>; Mon, 28 Sep 2026 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588317; cv=none; b=OvVHoH/G1wWIlvfe2EsOsWBWk2Nwiz0ReMX+ifqbTVS1xVjbIG7nznXqxJmVhjyNeOR5b/eAPwd7r+L8EMshC7I+4oyKbrKusW0iUgF/HbXie9Gv2MkBb3C7VnRbt6LAKGT02BVFH3l3+HViY6IQMr4sHcr/k3qOzgUD8+F6R1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588317; c=relaxed/simple;
	bh=+kAkhJWEHhORkLvB0ZiLI4BiCsph/1bD5skJT0GWRO0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HgAteFn0A3asXDVeWBN8Z950S2W1HNn+L9lbpDIHT9uEFo4mTjOxZ2YBI9obsibMKorQdcrVWUwF82L2+vdR6SWuXSb/4VHHtdLwrRsOhjS1z6f5yznL2pI4jHssEZMlt4hsgVlccQnO3IRP0R1nV7kb9AbgWka50LfzVuPHqFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2MFrGzF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2MFrGzF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4DC1F000FF;
	Mon, 28 Sep 2026 09:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588315;
	bh=+kAkhJWEHhORkLvB0ZiLI4BiCsph/1bD5skJT0GWRO0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j2MFrGzFHp7XNjCl9ZMMs6SuxGcwnhNZVp+wGKfil3zA87sirNbJZ2OJVA0GNPe5+
	 d7hoaleWZYlJZqVUCxOpT0WEbZid8Hm6cnYZTjVv5z7oMfCjsqZ/ED7AYH1+k2OkLq
	 Jt9QAbN05tH8OUF+vtoLtz11uKipbRhSVXtjTOu2eSJxFDkUMNflbOJKMs0tA0Y5Od
	 lDY0g7cZfcjr42letmO0SDBIwUE+xDUW5qQwOmmWQHrvmyDvBvPUfsbjVibxntuil/
	 4ytc8dQEQUf/hhEhyASE61+QS/ddEhXZy8+uW87ar00bpD0mOAJ1ly3glLRbYJmYqb
	 vounW50YaL8WQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 7/8] Docs/admin-guide/mm/damon/usage: update for
 quota goal complement file
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260928093342.16584-8-sj@kernel.org>
References: <20260928093342.16584-1-sj@kernel.org>
 <20260928093342.16584-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 09:38:35 +0000
Message-Id: <20260928093835.AD4DC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON usage document for the newly added quota goal metric
> complement sysfs file.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928093342.1658=
4-1-sj@kernel.org?part=3D7

