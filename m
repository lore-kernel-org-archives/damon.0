Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B2E1D9A66
	for <damon@lists.linux.dev>; Thu,  3 Sep 2026 03:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788404810; cv=none; b=fCiZ6Xg9BmT5TUdy3qu03C0ePgGHBAFdgl+19RDJD2EgEbXe8HJJ4x1UNXjntPH2JvtU3kjWDzAYyDlxtkYarN8EeQFnEkUQjrZolA8zRdxINHfvUpK5RWq9MlKQakxE5tN9QpNPm0x9reesHgtz28Kn2ampM+WvxDTFXZCKpWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788404810; c=relaxed/simple;
	bh=w1n+78oRxsXjZry3gpcMWGqXK1ZsA1r47ox3rDyd00s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTYHex9/R9574c9Awcvrj3W7i4o/U5Qi5aNhjXbxViftCDLHmSf3J19CcwyduHtYNMp6A98zVQQsE868+m6jDFsYOiO5KK9sQBMq4toAIaWebn0CoOQpTPZWwpoR6qcX6LfqmxqzjGHPAtAL6bZMpvrez9zxobn/2s4Y4gg6s7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rbp1Ep2l; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbp1Ep2l"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d8fd3b729dso16650735ad.1
        for <damon@lists.linux.dev>; Wed, 02 Sep 2026 20:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788404808; x=1789009608; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nA6TfANf9Ze+7t1hoZyjavPl8IZuFIwVPXJVLouCJ0o=;
        b=rbp1Ep2lWGb3So9eeW0SlLXnQXLuZ86nMQ8eO6W/iij1WGelcqa5YxTcHCbI+1tKkw
         dDDPKjF23vrNJk3S6zCnxW/gPUg1JlBEnNVWf35p10yr8lm/dX8YczqfiQm5KM3i9TPL
         5OfGbSdUWN2gU4iWCh2R4QUvDLBVbgrsH6oClx+M2/e9K6T5uZPWSn2AvnDMSgfebX6a
         VtlG4Wk6vPnoqjS1Q/9YDvaw1pOwSOxMvIQ6zByogFdWf4HfMgtoVrkI+QSftyDOabrq
         q3kexBMm0s2gQ8j+YruOALlSmt/K4qE3ydSJAHE7pN2PtSKvOq/sNyUhY/hVMjvTJwnk
         1ZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788404808; x=1789009608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nA6TfANf9Ze+7t1hoZyjavPl8IZuFIwVPXJVLouCJ0o=;
        b=mME2ST5jSS9sednqg2IQaQFaghju1LvHGzjuo9HegHLNAOPz0s7Iw4a+0Dus15ztRE
         DbPfJMTVUReeOGrX45Rt1pC+RE6NHhotCTNyOFACcZzmoeTimUmoVcv4ON8G2ZYVsIef
         jOFp/31ghCV1789RzRTYzRroOvPKsJJmB9kirXbRffjM6xg4LXVRE3usdssXfUxZazkj
         2LuXx4XbgkP20QRtSCHnsLAlqJUcJqL4Ecm7hegVjyjIPjm81bDEsjrD4U5dyJDR9aLH
         ADgZRUTSxRS9P7SOd9lXlUztN4YjaNX4ht3IQsB6wTltGMttoXXSK2KPORslm9qK9KY5
         HvwA==
X-Forwarded-Encrypted: i=1; AKwUvBxfUWvVzkyh2aRxR5gesZRkQu9TBg+2Yx+VrkZvLbMC8pqbry0etHMaDYxjHF/Pdhztvb0rbw==@lists.linux.dev
X-Gm-Message-State: AFuF++nbkN30LgP7npwDceanDEaUbej9PHlP7eP8Y+I7Drjdcwmv4gNa
	F9y5TbKFzrB/WfIaZioHzGNXSl/jEvC4+DI4IFNy0/mZkJJpUxPh5g6D8npAPVp6
X-Gm-Gg: AYBFou2RmhAVV+ihJw+kxSxEn0eFgRzKZDjp6vALmfCdLGRc7o7nzLLC6dKT1Npyax2
	5LwSdVkJYeVpsvT716nO3Ei1U18Enm1hEgzb7Gc4m2oW36HWpR9cUN6a7+z/Q2vpjIxue1PeRC3
	copxaR1NiPXnv0dXnnuqgkq5Fvd0MWguDgm/W+2N39fEs3NbtSz+eIILnay4hxuLCwNup/RwQgA
	Ouy3gSvQaB5WweGDhMBAoE2zI2jumOaWdKs0xbMf/JagQx4tqh79WXa9tMHEXTBycVuOFd2Lc4f
	j1lCkvZXKp+/tj9jL154Mq2vqMS3H7w715j8RJ7FDPa+m2CzD11x56wjVZMKXMeFKseI9wmjNz5
	lxv5dzRXRzuTb1Ytm/STfkcRV0eR+4IGTrvqrF1b3P5V/r5zuWQ+Mcvj8xpwauAm738jeEDFho1
	DSVe2QIPWmUY7WW1/D/890nQiSaPJUkY0TeUkKJpgh4GqFko07tJZuPigXwB8=
X-Received: by 2002:a17:902:d547:b0:2da:e68f:45b4 with SMTP id d9443c01a7336-2daec641a74mr132974085ad.8.1788404807892;
        Wed, 02 Sep 2026 20:06:47 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dafe0cf327sm2889785ad.11.2026.09.02.20.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 20:06:47 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH 10/12] selftests/damon/sysfs.sh: test hugepage_mem_bp quota goal
Date: Thu,  3 Sep 2026 11:06:38 +0800
Message-ID: <20260903030639.321705-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902054747.99370-11-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 22:47:43 -0700 SJ Park <sj@kernel.org> wrote:

> DAMON sysfs quota goal target_metric file now accepts 'hugepage_mem_bp'
> input.  Test it is accepted in fundamental DAMON sysfs file operation
> selftest.
> 
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  tools/testing/selftests/damon/sysfs.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
> index ddebde6edabe4..b66593c9ac471 100755
> --- a/tools/testing/selftests/damon/sysfs.sh
> +++ b/tools/testing/selftests/damon/sysfs.sh
> @@ -210,6 +210,7 @@ test_goal()
>  	ensure_write_succ "$fpath" "active_mem_bp" "valid input"
>  	ensure_write_succ "$fpath" "inactive_mem_bp" "valid input"
>  	ensure_write_succ "$fpath" "node_eligible_mem_bp" "valid input"
> +	ensure_write_succ "$fpath" "hugepage_mem_bp" "valid input"
>  	ensure_write_fail "$fpath" "foo" "invalid input"
>  	ensure_file "$goal_dir/nid" "exist" "600"
>  	ensure_file "$goal_dir/path" "exist" "600"
> -- 
> 2.47.3
> 

The added test correctly covers the
hugepage_mem_bp quota goal.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

Sent using hkml (https://github.com/sjp38/hackermail)
