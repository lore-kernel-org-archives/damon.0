Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8C63909B5
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789465704; cv=none; b=QSDE/7Y9cQgCCCV60AytqSS2Fdz23BMJ5aCgQEv/TmNkuPVi6XtldDs69cV2x8NcHqHM5Uhif2xMuvlzREMB41AVNgCJgWBh0VsTlZy0+ypXqtj1UJWdYgpEyX8C41C0p3/eyXKtJa0rk6zZo8Qr+0AJys7TXDAPxvmp91QTZ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789465704; c=relaxed/simple;
	bh=W5ZKzXnojJFbXaeZ0ScqXUEcw+scJo7xhwDVHaOTW90=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nq3Wk+/RSFAK4iBfW1SrK+VWtuZvh8y1Hz75sk4D+Q592AxF7oJ6s1P/m7KztpqNOC0vXybm3UmW8HKI7pezs5p2Z83YtXmk5t2uz8/KxuY84j9MqgsF1+Hi3XwJKfs8GIM2Cb7ksL8i+5ygyhvFn3umcidIK5CLaFTevodQ1Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3mY4OFr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3mY4OFr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788851F000FF;
	Tue, 15 Sep 2026 09:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789465702;
	bh=W5ZKzXnojJFbXaeZ0ScqXUEcw+scJo7xhwDVHaOTW90=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S3mY4OFrJ4JBJXbi2z7yPZlqTkvUqb8CQymyHz0KkN8opc5sKYjVdmsWmf7IToLFa
	 JPogouK6PZPnfMwI/PLewrrD06Fs8/Zvlp4m6rW1x5Z7j4xKHc44/EG2rf6Hh9dd9d
	 U4GKH8Ka1hIqcrbSY1ptMe5NcsNZAdKacG/uF6hjnCB9Gv1KYl8A1ur97RrBU+7YIN
	 YOLAuYUpJ8GuHDY4xaaeWe/3YnJC1TBegQOXGZRQ7Ojod5v1sLEe/0myU/4o1RvIUF
	 K0bjkTGwgOP6xyCUzCmjd1DyVHYbLLZf72+ePInhEZl12nq48WSU78fUvMtoU/bCFo
	 XzBY/u/hM7M3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] mm/damon/sysfs: propagate damon_call() error in
 turn_damon_on
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xuewen Wang" <wangxuewen@kylinos.cn>
Cc: damon@lists.linux.dev
In-Reply-To: <20260915093928.3389096-1-wangxuewen@kylinos.cn>
References: <20260915093928.3389096-1-wangxuewen@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 09:48:21 +0000
Message-Id: <20260915094822.788851F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_sysfs_turn_damon_on() ignored the return value of damon_call()
> for the repeat call control registration and always returned the stale
> result of damon_start() (0 at that point). When damon_call() fails,
> e.g., the kdamond is already exiting, the user still gets success from
> the state file write while monitoring is not actually on.
>=20
> Save and return the damon_call() result instead. No rollback of
> damon_start() is needed since a failed damon_call() guarantees the
> context is stopped.
>=20
> Signed-off-by: Xuewen Wang <wangxuewen@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915093928.3389=
096-1-wangxuewen@kylinos.cn?part=3D1

