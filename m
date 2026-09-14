Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC941481AA1
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397185; cv=none; b=pTTxnAdhgHbZSV1dw5WwfsN1iu3wpi7cyFOjegxJjoT5aki3pfpYtlTlcTDHmKMalDEHQ70fzEx/xVbwrxnZIJCiiCDRAW3YvDYxA/eTkzJl/bgDj1HjAi2rf49fvxOqHHYoPb4AS3fVb9zR0/UnQXv1cRCX7/vS/zVvBPy9Elo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397185; c=relaxed/simple;
	bh=qBnBDf9lC7Q5SgO0nh3I3QYne59tO3kvwayL9p4Deto=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dsYRkE4Rq2WiWs2IkoxvZ877P+7ds34kI6Qe4ZfZ59hfGbvnhWMzNI4gqsLCteqHhr/590R8pu5VY7ktIMyOCpfnDfUNZYrX0nIn90mI+LBxl/0izTd7Y8UW49Esy8qdFBuixzu9qO4o3w/cZNYANMyGL3LWDxUegpjvTXXdmuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M91ix7I9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M91ix7I9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6851A1F00893;
	Mon, 14 Sep 2026 14:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397183;
	bh=qBnBDf9lC7Q5SgO0nh3I3QYne59tO3kvwayL9p4Deto=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M91ix7I9FqA9894Rme/wa8kk/jHUvbElMC7KE8SYK2Y/Xt/H7xuncFxvRTTQ/pr8F
	 C83lCf8dv0VRPUFNXHlg6mw/2/CV9sWC+BNmJNkukuhRQxujJkv++oOeMcSBWzM5dA
	 yDvx3hpt0CjNDQ3rQRFoIAN0X6cCcB77rK5hpu9gujY93IyUJaZGaxLY0obm9qEFz1
	 4dDoQXExwxXb6KFvQ1EkBjIEFNma7+c3Pi0+FsRIVuD43ggft3pIyw0AeT7vUUdtwA
	 z/G7sEb/6D+ae5CKLAA9EXmP/87jsoKzkd15eEPnbggdzLwkJCKzjJzMaTFYo6asLw
	 A3pA9+fFrcjDA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 6/8] Docs/mm/damon/design: update for
 hugepage_size probe filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260914144448.93732-7-sj@kernel.org>
References: <20260914144448.93732-1-sj@kernel.org>
 <20260914144448.93732-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:46:23 +0000
Message-Id: <20260914144623.6851A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON design document for the newly added hugepage_size data
> attribute probe filter type.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914144448.9373=
2-1-sj@kernel.org?part=3D6

