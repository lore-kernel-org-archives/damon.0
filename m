Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6D8DF6C;
	Tue, 21 Jul 2026 04:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784608304; cv=none; b=t2SOc8lQq3j70TrJ0nrg79NMZmL2K9dLlIC20QIv+Voo8uOYnSIaHZFiYkUklFiu12DQrZIhourMgFAoRfa2zxoXS6aTBMzyJqscJSWoZ5d1DA+u/6j1IirxjQ1X7MGDlnbmFcVL5QoJNhG9nKdVaWlJAx1+xAXRCfelWQkJnFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784608304; c=relaxed/simple;
	bh=tZAU8wlLvkrD6vWyKlJOUksm7TbcVv1OQ39bAm2bnng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOn2IGRHaOqrei9LQcFqSMINNv7jT3Wt3VGJ74z7bRZ4wGDNveox+sed8Ywt5cwqZUftheAk1rSpFH4pql4FRZ8EoCSP+tapFqgATdiyaTP232+v1bAs6zJVMCMKtmZ4jaU3vBfKqNPR/MUiK2hf27rZEwv4fTmLCqn6jstrWlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBV5hQfz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBV5hQfz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EFE1F000E9;
	Tue, 21 Jul 2026 04:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784608302;
	bh=fZgnx8ZS5nr+FiTQpYq9+40sdtQR4bKeN8zATAftxjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NBV5hQfz1Dh6xQ8HtSR0sY6m1xs1TYQZlLihJVWqxV+Bf8BRcQK+qDb2kVnVJN2d3
	 WDPAKTW7RGFmPrZLbkzec+KbkiBO718+g1N1vuM2gimcUFcmCCAn8c4sjCR/Uz5wPn
	 YFJP4TlexJ123gV9osqK/2BOxx0Nfw8SW1Zx8gN9MiTX9fViIijzRmO39nUgue8YyK
	 37EAUd5KxgDPFy8IJqXma9HNEnNnj9s98zdOQdB3KyBNDx3V6nKUnfbcevxhPkv/8d
	 5vhF2hDwKxMOCLoifZwRbwgsYsRUNriDVx748w2KD0zGfyWwDKORx4yTvBwyLE6hC+
	 SdfTtzl7GRbIA==
From: SJ Park <sj@kernel.org>
To: longlong yan <yanlonglong@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH] selftests/damon: Add missing NULL checks after malloc()
Date: Mon, 20 Jul 2026 21:31:38 -0700
Message-ID: <20260721043139.151887-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721025802.298-1-yanlonglong@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cc-ing DAMON mailing list.  Please Cc DAMON mailing list for DAMON patches.

Hello longlong,

On Tue, 21 Jul 2026 10:58:02 +0800 longlong yan <yanlonglong@kylinos.cn> wrote:

> Add NULL checks after each malloc() call, printing an error message
> to stderr and returning -1 on failure.

Thank you for this patch!

Could you please elaborate why this change is needed, though?  What is the user
impacting issue that this patch is fixing?  Is this fixing a false positive or
negative test results?  Or, just making the allocation failure easier to find?

> 
> Fixes: b5906f5f7359 ("selftests/damon: add a test for update_schemes_tried_regions sysfs command")
> Fixes: c94df805c774 ("selftests/damon: implement a program for even-numbered memory regions access")

If this patch is only making the allocation failure easier to detect, I think
it is an improvement rather than a fix.  If that's the case, I think we don't
need above Fixes: tags.

If this is a real bug fix, maybe it deserves stable@ porting.  Please separate
this into two patches for each bug and Cc stable@ for easy stable@ porting.


Thanks,
SJ

[...]
