Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D22331F991
	for <damon@lists.linux.dev>; Thu,  3 Sep 2026 03:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788404681; cv=none; b=Xeuu1ag9iJxaOagCCO1MXwvb0abr5kUjh4vrBVoU4hma5yVvBFA23AaHULZy91Oa7Wy+15tXgC1JPkuIymLW4O1H2oNqdZcK/yys0kUfgtw8UyksVc+hj1L8s+muemTnV80qSK9m/Ls9XbyEeb9ea7/a8MuoRzDAJ86+XnKf51I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788404681; c=relaxed/simple;
	bh=jZiWYHItaHZXLwaaS6GizSmKCrgqOiwgtX+q1aMZoz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSzZgl1nzAYbiFHo7RmR6HLKfnG+W3HBXmG+XK2jNUOkPEaW81WifouBQDRPew7FwLTEru2klaTejxj172I9H9w3j4qfWz/J28zVlM6MznSAjp59v+mECT64+V38c6gXl7A2w3QHXQkaVEhL11mHbUfzzz8ZsCQQcyq3TWXDcrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzQM+Vb7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzQM+Vb7"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ce98cb8165so6628325ad.1
        for <damon@lists.linux.dev>; Wed, 02 Sep 2026 20:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788404680; x=1789009480; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PZ5VZbOzOAiIg21alHu3P1D5kKDO/4ea9+shULiGmrs=;
        b=fzQM+Vb703o3FSSpqiEdZw7/M6bKJDEwWDnb11/kwhaOQu9eAjghoEtkKlc8Ly5uy4
         hER0iup0HEdSC3WLpmF2LU89NtGHmWPiF14ps3txcoD3JK9g8wr9Rf6CT6Q0BCa6L6s6
         5sA+yCXIR/obfiqXzqhZ1aZDjtYdQZfWvRVCtwRJeF/iA9EaN3S5ZAHmCoqaWmtK7dl6
         J5oEvJ2K2ESNYgUWy5Xiz0miV6SpPlNFy9ywwyljcrTwpcDtsu7wlkbxlPGLn2MfqOvg
         N9t77jkvI4sxWXE7+mGGqCBFsF/lZTcmE4qAp4SXXFkMUKhskVREcNK64Wnjs4McWYVr
         ojhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788404680; x=1789009480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PZ5VZbOzOAiIg21alHu3P1D5kKDO/4ea9+shULiGmrs=;
        b=T9FDbZySxX/Q+yNNZp0nWJIW+lvGLRKOjsAXslTNrvfLlB50vv7MFsJhFMUNaOKSaa
         ilxO2TajdXTHQ4r2FqwqgvgKjMJKjMeyErvjfRbUirJodqA/UJDbzMCOTNYekLLjyz/x
         I6HZrpWpO4NDQx7PWircZ2Xu9RyvqauShzpQgJGN++6QGj4eLEzBFCqQD3eFiHkgFFt8
         i5PtFKp4NEa3TG/u++F96BFjhqENphEmbGefJAoun7sHNZb0i2yarWO3/orrOGeWSqcn
         1cPSPYFMocDKF+5hCQg7H5SqnEE7YghOlOdFaemw1KVR08CAxphNs29yxErXfVZ+tp8M
         xS5g==
X-Forwarded-Encrypted: i=1; AKwUvByeSF/aBUpRvKNvUqt2uw4pCfyJNmwuyy5vO8iSEU0T5SN0Jo8U2yAwWsXmBt50gWmJ6fGS5w==@lists.linux.dev
X-Gm-Message-State: AFuF++mmkts4azf8wE65AjI29d4g0Y17zF1BdpSohJt5F9YZYkDTQRZ7
	6NT7iIvRFROlxwkamscd8iIz4t+NZ3eBPyeFxfH+pM1OFLst63epBPLH
X-Gm-Gg: AYBFou1niHZQsF+KrHsi98/ls+DzU8Vu3VoGaIW3q9VsksdWtBhS+Dcd5Jg79tep/z5
	jyTiC+XnXw6ZyZLlq4Q8F3ZIBIuBBGzJNJSINuuUUsJjWbHhTaqjmEgu20mGQvJiJ0IxZdVuaqf
	F+phdO0XJlp64pvFME9O3H0PGyWBPK1BE6OOERNm61JjLa9PoSGBwA2Mjn8erwP6Kx2msdc9cDu
	JGClUq7KPioxiNP3PrKQi+8/VAFdzzoqnBjlO0u8IpfV+ijTmN7cQetpgQBjfWcIZ2aqtAurJPG
	8j8brWEIKnTyqJ3jsd9P5C6IanHfYaIhroaZ3WQMAgu/ZXGjs9u5NdkAXpjsvHA1lNUl6p9HaX2
	9Wox5cdfiL9YdNEIk/i4o6RDaBDEg0e0mh8ms74+TDzgmInmIT2Yy6xt/WgMEfoOCjDVfWC4j1d
	KNjYu9Fkd5ocB1xp8mZxIU2XzhG66t3TvBIgxC+zNBBBc9rP8wl5iH0xWk3SsBvf22947TZw==
X-Received: by 2002:a17:902:f545:b0:2d6:dcf3:b754 with SMTP id d9443c01a7336-2db020c9d24mr8716085ad.7.1788404679175;
        Wed, 02 Sep 2026 20:04:39 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dafec286d7sm2793645ad.51.2026.09.02.20.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 20:04:37 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH 08/12] mm/damon/tests/core-kunit: test overlapping ranges for set_regions()
Date: Thu,  3 Sep 2026 11:04:27 +0800
Message-ID: <20260903030429.309611-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902054747.99370-9-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 22:47:41 -0700 SJ Park <sj@kernel.org> wrote:

> Commit 954157679ec3 ("mm/damon/core: disallow overlapping input ranges
> for damon_set_regions()") disallowed passing overlapping input ranges to
> damon_set_regions().  Add a kunit test case for the overlapping input.
> 
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/tests/core-kunit.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 3cbbbcbfbef8f..a4164ac489a61 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -612,6 +612,17 @@ static void damon_test_set_regions(struct kunit *test)
>  			{.start = 42, .end = 21},
>  			}, 1, 1,
>  			(struct damon_addr_range[]){}, 0, -EINVAL);
> +	/*
> +	 * Regions resulting in same region after alignment should return
> +	 * -EINVAL.
> +	 */
> +	damon_test_set_regions_for(test,
> +			(struct damon_addr_range[]){}, 0,
> +			(struct damon_addr_range[]){
> +			{.start = 10, .end = 20},
> +			{.start = 20, .end = 30},
> +			}, 2, 4096,
> +			(struct damon_addr_range[]){}, 0, -EINVAL);
>  }
>  
>  static void damon_test_update_monitoring_result(struct kunit *test)
> -- 
> 2.47.3
> 

Hi SJ,

I reviewed patches 6-8. The test helper extension and the added
error cases look correct to me, including the overlap case after
range alignment.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu


Sent using hkml (https://github.com/sjp38/hackermail)
