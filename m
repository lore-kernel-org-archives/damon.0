Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E843748790
	for <damon@lists.linux.dev>; Mon, 12 Feb 2024 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767027; cv=none; b=LC1XU9GeWvQh8LSWta6kQdxSgFiACjpOAahxyqUHe4J8mdWP1LdsEenO2C2eyKGnCbDvpOpn3PcuefdKV2eTBliPY5OAbQ7yryedoD2arIzkSrTUQmF2V0Vtu/OriWly4j1nqnp1f4IdBvZeFNZ6Ja6UTzzegQkhKc0GhJ2c3+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767027; c=relaxed/simple;
	bh=8NjLdLZGYSTfZoJpc8zfFGwf3RhBla0sf8Mk3cizRgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X3u8+S20vSRWfnYLO9DEQCEhQJDVA7OVOK/uofRwupmimt4WyuUmKqT5/uCQWfODROBFBZRfn8d2CkkSGSecpHABgw+hGDbWozxsgdkNH+c2FYTL8levLB14Zbj+YVdJxu/yBG0md3x0uptrWIZjSIFlkPXA/bQBAiKFs/B+9ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlwfI4j9; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlwfI4j9"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d0f1ec376bso20175781fa.1
        for <damon@lists.linux.dev>; Mon, 12 Feb 2024 11:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707767023; x=1708371823; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szLEne8dk3CvpXCYVBedEJwr7tcaDdWjuVgZysah37c=;
        b=BlwfI4j9EGy/UFkd8AsKetDD9Ow0QEbLRRw3+brpLJzMHP8xRxRJsHNnGKBga+AFsm
         6Z/tZ9Hr27kieBZhm6YAhoiBOac/hTLuhLxCr70iA2SMkCyIfI4oSNzzAlATo02kzC7y
         U0sguxlNMyLDXG7UiqhOp98EW61XUQZljbrVV08fZWPHVwoybZL9Ps1dvZE9IQYNl4Pu
         KYE6D85/0URGGo0aqpGk44Ec6N/ykK/VpQmXdeAZY48bs9EGw2roQnx8r/hBQZSTakIN
         bSr5y9/ANLNYEfT0pV5znWiOqjNtRVSZA2LX3Kd0/2kvzXg522dhXIwZWEoEUyqLfAEv
         wSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707767023; x=1708371823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szLEne8dk3CvpXCYVBedEJwr7tcaDdWjuVgZysah37c=;
        b=HnZ1oJDqOHpx0yCc8MsrolRaas+tih0Ly+qWgFakvuJFQnaZEqEwatJ2poE2kB9xN5
         JbKuaEjUX/mSLSqm2Wt8HOSj4w4rE+oMgcJhnAHK4VT85R7403hcaJqBFno2TeKJslwg
         71vbTnfbCpwBpb+7ihD+apV7erZhcrTg7+4tGGj44j0cBj0mCWGjCWykb7MrkwqKDao/
         ztzedKxIy0/LnvefDzeqPT82vkdcpzrB0wkKxQFbBJn5AGXIfaCisJSMyOQjVOB/SgqF
         LXo5FUewNyd+GiKE+vciCHHu/EV1wivfe1ySsOUKimcAH1sq+yIp0yWP3F4qL7NOL91S
         znYw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ3TFg6EjB+aoasvOyPd5ICbzPMqGC7nHUi5sQo8wejL700z0v9/jiNd5WZBt6xiH1tejb1VgO2uXrWJwFOLS1lm0egc8=
X-Gm-Message-State: AOJu0YwelG0rrYST7S21PUs9zxh7e6FksnTQswRI0RC4DmcnV0G8u/cq
	G6V62Euc35uFn88OXOAWZ2Pbz3oMLJjnnItRzwPdRldZswSkpyHHVqKkzqA+2ulsKQ==
X-Google-Smtp-Source: AGHT+IGK044jQrENs6iu1m1lQbDng4kur/ujq0w8sAqaEdG9uw9ii3DWUzE/YE1PwW5R9MwXQpGDQQ==
X-Received: by 2002:a2e:a70a:0:b0:2d0:b644:57ba with SMTP id s10-20020a2ea70a000000b002d0b64457bamr4318612lje.35.1707767023419;
        Mon, 12 Feb 2024 11:43:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7Q/eWfCg3+4dsADtfwBzTb+hcpw20Nm30oHQ+rXaCNKv5F6/QJLfLHOK30J/WbDxawFxvGP0a2pNHLxtcXdJLDNf0F/4GTaVwh62STs7KYevXmo1lR7j5WAOnQA8BO3c7ihJljfj0emt61i3gLp9pYBA9xWhWx+s2NzKLWRWhpUPJtqjY3cOJQ8ZF8lScVZfc5ZeIgtYCtoOCi/B8z9/jBFji5hQF4ZtymkdVoZ/Hhe4lQLeibAD5NDNKdjsEoIcx
Received: from [127.0.1.1] (2a02-8389-41cf-e200-8e14-1b8e-d285-8c63.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:8e14:1b8e:d285:8c63])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090699c700b00a3cb136aef0sm502323ejn.224.2024.02.12.11.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:43:42 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 12 Feb 2024 20:43:39 +0100
Subject: [PATCH v2 4/4] selftests: damon: add access_memory to .gitignore
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-selftest_gitignore-v2-4-75f0de50a178@gmail.com>
References: <20240212-selftest_gitignore-v2-0-75f0de50a178@gmail.com>
In-Reply-To: <20240212-selftest_gitignore-v2-0-75f0de50a178@gmail.com>
To: Shuah Khan <shuah@kernel.org>, SeongJae Park <sj@kernel.org>, 
 Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 damon@lists.linux.dev, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707767016; l=636;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=8NjLdLZGYSTfZoJpc8zfFGwf3RhBla0sf8Mk3cizRgc=;
 b=RQbbdMfYd5+1Ea7LF9i9Ek8b60WTUXImPXFGgW5Txc1dS67V7ZpnjY3bIsKAkN+AeyhKJ8hw2
 giNFEmE+yjqBS0D4lIFuTVkmAxAIBM7Vdl999TMk2/LHCuxqObyc7s5
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

This binary is missing in the .gitignore and stays as an untracked file.

Reported-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/damon/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/.gitignore b/tools/testing/selftests/damon/.gitignore
index c6c2965a6607..79b32e30fce3 100644
--- a/tools/testing/selftests/damon/.gitignore
+++ b/tools/testing/selftests/damon/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 huge_count_read_write
+access_memory

-- 
2.40.1

