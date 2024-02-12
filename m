Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1086047F4D
	for <damon@lists.linux.dev>; Mon, 12 Feb 2024 19:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767022; cv=none; b=Rw/OJWkoJvc+5ZRo8WaKfO/50yOcnbvDtaR+3CYGxRS22wPJCHaZxzeTZbuFEh1f5xZmNPv2zN5mpOVvFgOFf3cYNndRj0aWhcgEF/YGJz69FubzNEEALLrTJEQO8Ta84GedrzSKQodK0y4zdFKoK/E5+rwqzIr2+FydoZzArxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767022; c=relaxed/simple;
	bh=WtHVq1MaM2xClIr1rMsfIROFbVO+f54SK2iXyPjvLXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pg7p9bG6pMgnXXxWM8RgUD+Cz0eeUgCO3EnHE5COjUsPxji7NKgwWJ31FzKyWGKNR22WDQkxDbPIyBZBAzBGdD8j0SpSpCHDSMecwigu6dKruSR+FGdDM1vapfTRdRWlWvN2D31UYMVne08ena9FMbTLeCRk3DSkXEXBYaQH0LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9r9mCaw; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9r9mCaw"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a26fa294e56so482821166b.0
        for <damon@lists.linux.dev>; Mon, 12 Feb 2024 11:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707767019; x=1708371819; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aW4knlrv1UA9D61zJujTvwkGENLspNvcPvyx+chnplU=;
        b=K9r9mCawbvd68fanwB/IXV3FSZeNVf2O1mzAgUJvW+UYfNGoVrT5RuBcL5ayaR7wnc
         W00IS5r60Z+mN3kCbI1/e/FRc1a2JMKZYgGw0k1BQOIgdNRdOcp+MMytFMJm9puHBw9N
         ZGlyVsjVcbsmBd3OymTp1Mq9JDAd90Hm35Y8/ODUIx7G2VO/uhzvMqYgjUSLNjdESjL4
         RAoWBxPzMhPCAAwxUePlvvEwqBdwmBRwVBIdyP8F2RQvMHkvaj03fyLb5o0sFz+e84+R
         bwIW7rYRFK8A4Qc/6K55Wwg4+RFuuSaXLRfZXmlnu4ok01XfPsgQCXxFODUZsaeGFuJA
         uByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707767019; x=1708371819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aW4knlrv1UA9D61zJujTvwkGENLspNvcPvyx+chnplU=;
        b=gmPagXLHzTBkR3bfEwrIQxrRqTv+gfsMXye4oGnmZvNPjIKBhfHQ9HclCMxwX+JSW/
         iiiPGHjz0EdSFycnuXWNYuJ6xYz2x67OAEGX3zKQq8tfO/vBitQ6KuJJ3VpUC9F2awqB
         3TjznTPMit4ab7sck03TnG0lt3YpsHXbev43uci86I2B7yxoiahTCoLQyAWmVwh1Grug
         JXH9ZEgSg1i4ZEXxVQuSKyX48lPk01/vkmzs7wGGXWq2CcYLEzEbvA5uyFe3njr7HjE6
         Cggg9Xn8enLezbayCnT5FnQQscukkBslYl1HiSpH5Y2DfQVAoc0z53mIkvT0ZhxcoB6T
         7MvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyT9hmRq4PTOr4sw+5cqysLfNDUuBTjiPyjOB6yOcsA3rO36B8o+cK+ru1iNJ21Zwdd+RNBDh0k9233mwUsTeuPyohJUU=
X-Gm-Message-State: AOJu0Yym7AsfiNNRiXJqDbh3MY/Z/M5bUi3++wYDRHCedYTUutY1cbyH
	1srVrsQJPO9CDtkw9EDa4C0MW04Yza8XWCMC+SzWUvnzwu/nuobkTeHjY0zlbAJuqQ==
X-Google-Smtp-Source: AGHT+IHwhObwAJmnYwqvu9MYKQ6IcT6WU6U5gGizU5ooPxRkv0ccZNWPTsS2bXI76EifnDCFFSw7NQ==
X-Received: by 2002:a17:907:b9c6:b0:a3c:843c:6d6e with SMTP id xa6-20020a170907b9c600b00a3c843c6d6emr3691563ejc.15.1707767018935;
        Mon, 12 Feb 2024 11:43:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4WsBjIbRwp9Z04SuN95f9z0hvmdY68+8W/ECfjK5iDKO27rvwzuzsWYFttpYhHLTbnFeRmW5FEKXwYBIKAWFHqN7C4GU6w2k1X8PqBzhW9hatjikRcz1pHQDIR9+KXudNaRjKbept6x0AO9Rejo6IikF2INockUyKpPHrjf+YjmxhsoQYp0bfsF0ie6IVrIXgQSoBg/ZL+CDHMdCNltkXVSYk/yVWuVYhQl60ljwSGKaDSkAGeC0QPH21Z3aN1hfX
Received: from [127.0.1.1] (2a02-8389-41cf-e200-8e14-1b8e-d285-8c63.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:8e14:1b8e:d285:8c63])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090699c700b00a3cb136aef0sm502323ejn.224.2024.02.12.11.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:43:38 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 12 Feb 2024 20:43:36 +0100
Subject: [PATCH v2 1/4] selftests: uevent: add missing gitignore
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-selftest_gitignore-v2-1-75f0de50a178@gmail.com>
References: <20240212-selftest_gitignore-v2-0-75f0de50a178@gmail.com>
In-Reply-To: <20240212-selftest_gitignore-v2-0-75f0de50a178@gmail.com>
To: Shuah Khan <shuah@kernel.org>, SeongJae Park <sj@kernel.org>, 
 Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 damon@lists.linux.dev, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707767016; l=672;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=WtHVq1MaM2xClIr1rMsfIROFbVO+f54SK2iXyPjvLXA=;
 b=5ZgRb5GVufPB2pMDIOqRa2V2z0FkI9qlAiELwAb4h4Pf8gZ+Q5jEhCnqFlDwZaFMwt5dyztIx
 FbZEdTJs7GWBy1RvOpDpVB8hCPPJvlm86EfuAryrRSZ5usjrIQw1HnT
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The 'uevent_filtering' test generates an object with the same name,
but there is no .gitignore file in the directory to add the object
as stated in the selftest documentation.

Add the missing .gitignore file and include 'uevent_filtering'.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/uevent/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/uevent/.gitignore b/tools/testing/selftests/uevent/.gitignore
new file mode 100644
index 000000000000..382afb74cd40
--- /dev/null
+++ b/tools/testing/selftests/uevent/.gitignore
@@ -0,0 +1 @@
+uevent_filtering

-- 
2.40.1

