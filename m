Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CFF3EFFA7;
	Fri, 29 May 2026 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066879; cv=none; b=nVJU8aCqtibkp5byFNUJxmyGlUF/ko81075dcgPeUIgWsZeIM+e4ktAbeMFuFpuyurWu/+vVdwOWj7R0AhUDB0FgP4MeRSgpS1KfO88DKvD/2+PrWrj5hQKnJ/EgvifDki6Ll/6hXkK+3pwQPhRjCqkJwTkqWVWsbP0X2DfmwsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066879; c=relaxed/simple;
	bh=rNKzhCNrBj5IYxTx8D3ydu7Wxfpbm5o4p9ZaZ5Rrvus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ra50dZDzYlk9/eIBF1JwvNB/zPBFdFrTFVXpCM0zIswhAvF2aOcP7MYF2muQ3qxn1YzhDIk6TSGvKhigiNbqi2DsQ7f2gBbjkQ5pU9UQoUnqIhOBgY4os3xoQW9rjA2O5Z9aFBm24eeldImefdsijqDn531RG3fvlOuonFlxheg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1b5V6y8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1b5V6y8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825971F00898;
	Fri, 29 May 2026 15:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780066877;
	bh=3ShsIQPosHpMnirHmH4xFd5qCR/Qbqzv+ZOS1pe/kbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K1b5V6y8fHjzldH5MYPUCQotj/88kq8UPiKAfP48FgDCJrs6LhbUNWDZhSKdPE3EW
	 cwvLI+8VBgLRWCYaCGMTsPYiEF7QemHD845Zty5y9YE+GHnJ44pCOXM2hQ5QfLPVvE
	 D99s61wSEjQ7keqXkTRrUulvX0970/bUO9XAwoT9lMH+HrG6LBqU7CLnssLHMPBncQ
	 j4S5rorAIowxpyDjPSRxAaDE+CcDZjPrhZ/QXEtfpf014sggaYR7BXL6K86trSO0O3
	 nP6EtjrDyo480gssnYzAsy63XZxpSExgzFTDPKeH8nag1UNciYV8sxQ613Vj/ehhtk
	 QYTy2uJHwB5eQ==
From: SeongJae Park <sj@kernel.org>
To: Cheng Nie <niecheng1@uniontech.com>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@uniontech.com
Subject: Re: [PATCH v2 2/2] selftests/damon/sysfs.py: validate memcg_path staging readback
Date: Fri, 29 May 2026 08:00:56 -0700
Message-ID: <20260529150057.84753-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <FF9A1552C03B7C88+20260529092131.1703337-1-niecheng1@uniontech.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 29 May 2026 17:21:31 +0800 Cheng Nie <niecheng1@uniontech.com> wrote:

> Add a dedicated test at the end of main() that writes memcg_path to
> sysfs and checks the readback path.  Validate the readback rather than
> a derived memcg_id so the test stays focused on DAMON sysfs behavior
> and avoids depending on the local userspace cgroup mount layout.

Nice addition of a test, thank you!

> 
> Signed-off-by: Cheng Nie <niecheng1@uniontech.com>
> ---
>  tools/testing/selftests/damon/sysfs.py | 39 ++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
> index aa03a1187489..0f20bc9c46b7 100755
> --- a/tools/testing/selftests/damon/sysfs.py
> +++ b/tools/testing/selftests/damon/sysfs.py
> @@ -250,6 +250,43 @@ def assert_ctxs_committed(kdamonds):
>              if ctx in ctxs_paused_for_dump:
>                  ctx.pause = False
>  
> +def test_memcg_filter_memcg_path_staging():
> +    global kdamonds
> +    memcg_filter = _damon_sysfs.DamosFilter(
> +            type_='memcg', matching=True, allow=True, memcg_path='/')
> +    kdamonds = _damon_sysfs.Kdamonds(
> +            [_damon_sysfs.Kdamond(
> +                contexts=[_damon_sysfs.DamonCtx(
> +                    targets=[_damon_sysfs.DamonTarget(pid=-1)],
> +                    schemes=[_damon_sysfs.Damos()],
> +                    )])])
> +    err = kdamonds.start()
> +    if err is not None:
> +        fail('memcg_path staging: kdamond start', {'error': err})

I'd prefer the error message to be in form of something like "'memcg_path
staging: kdamond start (%s)' % err" for consistency.

> +
> +    context = _damon_sysfs.DamonCtx(
> +            targets=[_damon_sysfs.DamonTarget(pid=-1)],
> +            schemes=[_damon_sysfs.Damos(ops_filters=[memcg_filter])])
> +    context.idx = 0
> +    context.kdamond = kdamonds.kdamonds[0]
> +    kdamonds.kdamonds[0].contexts = [context]
> +
> +    err = kdamonds.kdamonds[0].commit()
> +    if err is not None:
> +        fail('memcg_path staging: kdamond commit', {'error': err})

It seems we don't really need to do commit().  As Sashiko mentioned [1], it
also depends on CONFIG_MEMCG and active cgroup configuration.   It would be
suffice to simply 'stage'.  We don't have stage() method on Kdamonds, though.
What about setting all parameters including the memcg filter at the beginning,
do 'kdamonds.start()', but ignore the failure, and check the content of the
memcg_path file?

[1] https://lore.kernel.org/20260529094327.6D5031F00893@smtp.kernel.org


Thanks,
SJ

[...]
