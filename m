Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2165485951
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398123; cv=none; b=kMvug/0+UnMpCXL0fd20JFFJXy4ZNqCUqtbWGPr4Vvd/PFK1uYraU+4dDSCUhJiz0MpIzIvsNb7i9nvutJObJ4+ugDhepD78ZeglAS34MPWkm2tWeoJRcrIVHMRK2vcNm6sO5gOTAcXiuXRHk4SbHvRShRJugeK/wt40HFWxnRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398123; c=relaxed/simple;
	bh=+nX5Ss/JCqlucqt2lHr16phOts4ObE89IJZ0PKgOvM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rpe/NTXJvSVyanpXvm4SeR367ULMEcE521vgRK7HInq1ygaNfpCy+AA7vxxLm5xzvOys7Verl29UJ5OB7/mZcgKi0oBlDs8OJeN+jklros5WJgrSp04BjXkm978oNOLUXRa9a7WEYYaSpT428+XqnZGK/hBa9ROYHd78QdU0OWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKx6mIJz; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKx6mIJz"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso3393636a91.3
        for <damon@lists.linux.dev>; Mon, 14 Sep 2026 08:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789398119; x=1790002919; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T8ygL8wnvNbDDwp9bVOKE2bOGvJgUY1pPihHcbtZmW0=;
        b=lKx6mIJzHORecsk7923DUxLXau8ewtTMuczIYD2Zc4pG4m5J7Ecg02ecISAPASXAHX
         Uq7BE6Ua+V1SL0bugcsiA4pePRP2pZT8hU3NZv9/x4U+s9WrRCqbpmphEQlRnSBo4Nsu
         XLbAxhiEP/o7DuLkR/844EuJpbtaYCC6tWeRuzDe4Ji6nLviWEzTTlmMUxmghEs62ysv
         emGrwmeoqW5ONwFhnygtffn2ksKA61++j9coQiHuernxS+65C5F2785XZn21oefWAF8J
         iRm6i11yJXSjhPcaIdmONWG3ZQBXqL6xAgBY0np18lbDb9akwMHNKAqgAOwiZhUAB+PO
         rzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789398119; x=1790002919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T8ygL8wnvNbDDwp9bVOKE2bOGvJgUY1pPihHcbtZmW0=;
        b=So/0ljcUtflY+lwV6klNNQ4nGbje3Ee+al4rNsvrtQ6KCb6CladomIAa/U07zbJMmF
         Sxo2eurcI6a/HdKSGBMevXxjQ9SfypBUlqXCDrDm0PYxHKbS1hGxCrAYn5LD/YRpy20g
         oYeBSO4TE3eoUTsJtoJsIF0RZyeZvrg1YkEXsAQJH9kEE0ju2OHGQRf/mFtfOV9/Jori
         Q0NneVTfmHPFKmK/apgrIfhFP4bhfOAf49fTkE+7Ovpg/N7BEJjKOpCAGIg2lvX/pKmb
         1F02vsh3uBwr5LsPbTw9jQtcJ5OLlqUSPVkJ+LbFndUW3ozBr6yytp6m1TuBiywppyU5
         oUww==
X-Forwarded-Encrypted: i=1; AKwUvBxsDiOzZsIa7lw6M8d3hYGZL0N10jJf2h6XqwKnL8Mc3scjPRXGLcO41PJBGaCDSK51MTTgdw==@lists.linux.dev
X-Gm-Message-State: AFuF++mwYWvrnAGpgznohF4T/BBkOWmO46C2CV1e1hU127vYD8Z+mYC0
	XicUkxlOvl5OQnOD3l1jy9kPHW+ABq2XA22xuydeLHx3dc8hJ3IggfPt
X-Gm-Gg: AYBFou1+z50GdceSsN7hGtdhAk8BEV+w2+prscNsLD3vMVcA220oX5MKRBceQHGbV60
	jJMLVK2d+plGlni+7JqZ0SQRVot08o3/BamtFR3HYwpmnXFoGoTrZQ+6KhljwIujlmA6ySKyUHz
	5w7MhpZaNpGVPcQgXjESP/RHWo6MY1xZ6aeuGF6gHSUqBPcBJU7QfwzGk4PfDF0gnzgtumnQJi8
	D9nrNV9CWkR9YyHZ1eRqX/fWJetgKgDWSAypey/bPdPoXvSoYoTON4pp8c1FjayOkphKJVdGTZQ
	Q48is4g957290U8DeEK6sMsxsodU2y/nNKmCSIzqm9zjtTLkolB4XbRgj2z13rmzLZxaHCTx6qZ
	dolX4SXozs82FYMpa2Fp/V7CpYo1XB+RR8SKwwBUZek+E8a/TzbMl762k2fVVlkMhqWAWq/OLtl
	+tBfzeCSnQa97GEXCepx3jtvSgTB+4U+RQdVkBKpJ05acQ6vJENAvb4riXDX0c0C/P4GZngtI=
X-Received: by 2002:a17:90a:6d90:b0:39d:ecb6:8d40 with SMTP id 98e67ed59e1d1-39decb68d5amr4014856a91.4.1789398118233;
        Mon, 14 Sep 2026 08:01:58 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfd8c84sm50939035ad.62.2026.09.14.08.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 08:01:57 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 4/9] mm/damon/core: use damos_quota_is_set() in damos_adjust_quota()
Date: Mon, 14 Sep 2026 23:01:48 +0800
Message-ID: <20260914150150.1507525-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912200814.145612-5-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 12 Sep 2026 13:08:05 -0700 SJ Park <sj@kernel.org> wrote:

> damos_adjust_quota() is manually checking if the user set the DAMOS
> quota.  There is a dedicated helper, damos_quota_is_set(), for the
> purpose.  Use the helper.
> 
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index cf10f6d725c19..dd27068cb83e3 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3344,7 +3344,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
>  	unsigned long cumulated_sz, cached_esz;
>  	unsigned int score, max_score = 0;
>  
> -	if (!quota->ms && !quota->sz && list_empty(&quota->goals))
> +	if (!damos_quota_is_set(quota))

Hi SJ,
This is more than a cleanup, because damos_quota_is_set() also checks
quota->esz, which the original condition did not.

The path that makes this matter: damos_commit_quota() copies ms and sz
from sysfs but not esz.  So if a scheme runs with a non-zero ms, then
the user sets ms=0 and commits, the running scheme gets ms=0 while esz
keeps its old value.

The old check would then return early, leaving esz stale.  That stale
esz is visible to damos_valid_target() and damos_quota_is_full(),
which also use damos_quota_is_set().

With the helper, damos_adjust_quota() proceeds into
damos_set_effective_quota(), where the first branch resets esz from sz
when ms and goals are unset.

The code change is correct, but worth noting the behavioral change in
the commit message.

Thanks,
Kunwu

>  		return;
>  
>  	/* First charge window */
> -- 
> 2.47.3
> 

Sent using hkml (https://github.com/sjp38/hackermail)
