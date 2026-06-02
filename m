Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB90D3D1CA8;
	Tue,  2 Jun 2026 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780409639; cv=none; b=Y+cjKmr7NMIzFMg/vwxF9uDIH4fAaHADtq4rKP6dmCcTzg08bdzKCEonUYCMdYchq22l6uZHomtgBY5SO1NqmBKxu4DkWvNyEuC155Qk7s0xeuoUT3gYkPO0pfQFdnLQuPTs6J6BBaci1ujvIwiWh6zev/slLCX6P3pVchDC2QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780409639; c=relaxed/simple;
	bh=kzkPf4R0GJMSG3yPBWiHNqyEN7Aq+zp1h/gKOJos63U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbIwhaS4NLU0tKCtm+QPbbp68F7ZbpYvFPqjn2Gy4emACI+VVMcIb3wqfMorQtmgOJiTD5IQK1WpXBJGLRf+a7UDwY5hVlTYpbQCOlsvhuKRDVfcumQBNc78nf8Ns1sG8qql5aAB/uRz/miaZQr/UlCBUEkyj3A/Oxe6khJDQdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rv/vc6Rq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv/vc6Rq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DBA1F00893;
	Tue,  2 Jun 2026 14:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780409638;
	bh=1Da0hGHRQ+u6EMu8JOWarmoA+lAxekjyOANZmQgjUI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rv/vc6Rq3YhE6Vacsb3plHHgWxNahSbe1mNpDtLyb9Uio74S65fjQxTJgNxUExRkv
	 DB6lL/S/394EBIVzKoOBtNMHw3o0gzMpdFJ7jGNznmhAaJKU3LMdDHcrWqodrt3/DK
	 nhKCESyl4IrdiepEdcK/glKszRYQDCcIs/7RTxVu8UZDQOQT8Ydir99zx/UGjNrNOv
	 GrAP5v5AN73YYhp5+oGM3Br73FerFxPt7/5H/MufCscbE3XYgCyVeXFsdNX516iJe7
	 NkcAF+VjtFjOMibA3owVxDTdEdCDY2Zi9goO1V2u3ffBaq/Xos2lmucHn0a1Fz8RlQ
	 nw4cru+UUv9Eg==
From: SeongJae Park <sj@kernel.org>
To: Ruslan Valiyev <linuxoid@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/damon/_damon_sysfs: support kdamond refresh_ms
Date: Tue,  2 Jun 2026 07:13:49 -0700
Message-ID: <20260602141350.101848-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260602131217.2210912-2-linuxoid@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  2 Jun 2026 15:12:16 +0200 Ruslan Valiyev <linuxoid@gmail.com> wrote:

> The Kdamond class has no way to set the kdamond-level 'refresh_ms' sysfs
> file, which makes DAMON periodically update the read-only sysfs files
> (DAMOS stats, tuned monitoring intervals and the kdamond pid) on its own.
> 
> Add a 'refresh_ms' parameter to Kdamond.  When it is set (including to
> zero, to disable the periodic update), write it before turning the
> kdamond on, so tests can exercise the auto-update behavior.  Leaving it
> unset keeps the previous behavior of not touching the file, so callers
> running against kernels without the feature are unaffected.

Nice addition of the feature, thank you!

> 
> Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
