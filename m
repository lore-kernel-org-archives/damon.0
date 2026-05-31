Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C079250BEC;
	Sun, 31 May 2026 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780245054; cv=none; b=HQRHCgIY28YyUOQCA+PLZ74sjagzCLy6GRtDpLCIM6+BzMrBWVfphhejshFCsF9BlosXqU/blBhMjlStc4/y7bbiy+s6ptZ9QITcdOhQrMJbEykyHLN1nBUK0fmmA5VASapNBWoy+ADQSEql+ikg3nTLXBqqr1oqNVd/oWgGqG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780245054; c=relaxed/simple;
	bh=WxxjZxPah5rdAM53jYK0+5B40jxYAg6z0iixAmKZfmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9nBv4y46dnXNEZvzju+jGN+q4vlVQckoSMMffYeSAyNC1mk21aZ7hQP57mG3q6g4y20haDnk92MlpJSvYM2WWXVI/vVR6UgTyBIYFU2P0VK3VZ10w7QxYaZEA9GglHnwMIPTTQTY+oPtNLfpxi1ZeBaLLCxjrs6H86jhrzQ2Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=et2lfG5Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="et2lfG5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12421F00893;
	Sun, 31 May 2026 16:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780245053;
	bh=ooHLjrYde68IF9paeXUdfTOnJaxqfaEudXi3V/Gpzfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=et2lfG5QLbYIoA3FgGbare5SGurLAvM5KBRLjqiOh9RUqierVbKf9wzyH3wgiGycU
	 tVJhavGlm8ky4grJeEbtbgCylyY0hbuqLt/+qECeq3e6+idodR2N/iiCmbGpLWd15W
	 X4ouvEPx3w9juaWoxSGHtEad0nv8FsGaOGB0uWm1BWZYzQ8T5JNx3h0qPdWxxLyq1b
	 4wsEqQx1Ntt+GA/1nNhWfSyn2kEqOItpBH8H+15iwZdJhyVjEv2afMgIjHwC8bI3Al
	 dC2P3qG+Kw8nNQ8BeF4js2pbcn4dQKerZ3462G/HkGjQvXkGJs7YKEG6NtOFx4Q3Cl
	 qzWAJvrxehV3A==
From: SeongJae Park <sj@kernel.org>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH 1/5] selftests/damon: prevent cross-context state pollution in DamonCtx
Date: Sun, 31 May 2026 09:30:49 -0700
Message-ID: <20260531163050.98908-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260531091724.84381-1-kunwu.chan@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 31 May 2026 17:17:20 +0800 Kunwu Chan <kunwu.chan@linux.dev> wrote:

> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> DamonCtx.__init__() uses mutable default values for
> monitoring_attrs, targets, and schemes.  In Python these are
> evaluated once at function definition time, so multiple
> DamonCtx instances can unintentionally share the same lists
> and DamonAttrs instance.
> 
> Replace the mutable defaults with None sentinels and
> initialize the objects when needed.

Nice change, thank you!

> 
> Co-developed-by: Wang Lian <lianux.mm@gmail.com>
> Signed-off-by: Wang Lian <lianux.mm@gmail.com>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

checkpatch.pl complains as below:

WARNING: From:/Signed-off-by: email address mismatch: 'From: Kunwu Chan <kunwu.chan@gmail.com>' != 'Signed-off-by: Kunwu Chan <chentao@kylinos.cn>'

Other than that,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
