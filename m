Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795434860;
	b=R4H9MCgVNDMaLlgDKC8my9GhRLAHL6gUM9Lk1qfBymbDm86k1F/swBhYTADFq9jtijtZ
	 ZKIRaw4WO84xuf1CdzCCrI/oTV/Zgxv8TIpQV3+aj5SG82Gn3fPPA9NWVPP23DaPTeQHT
	 3aj9Pl9gzTihZj7qAyx0pbDkmi10vgdElXTQsdirCqs3tKke3PUpalfRpgUtkTM29xtaP
	 3rpDkFnTctzcNz66tbR/88n7lH4jlesBWXEgEgJg/e8ASjXtpdB8tMTXpCD744VMzqKq7
	 XZeyZOJaBPSPzJLZffX/BydH5VxgcNX0sWLfSMJyXNdapnE4fs2dJtfrlJHOzgMurJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434860;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=o4oNKX9YSaQ7zR9YQ0CZmPGolVckVsLjzNRd1vRsTh0=;
	b=lLL4PuV9zdrhmhll2Bwq52Y6WiUO7VddHsshxQ40zrRNzjmPcQ+xYQVKsCDfbtp5oKXm
	 pcFAskPamC6WakBcOEhr/n+Uwjo3TynDRkqC9FzzUGezimKYrkkQ92G3OyKdxOeEA4YJH
	 9O0Fxmse6rCFhh+JZVqQGAfx/iFFNdCeXvjDjgwCaTES0WiSYArZS5ektMujfyE6TdlXo
	 bgJk+lu57hhhwMRbo4kRz/DSeyrCDfy/MZCHm9OKnB6ExUpayXGmC4G83T9ciZRCzDIQg
	 9a5l7u9gueYE9sMoDKVYZPLxo4ZrtjJnFQhfmopPdUpLTO79IbLAxyNVE8eOPesIKiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aDR0cqSt;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145E0606A31E
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 11:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 145E0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aDR0cqSt
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-38431138772so4071526eec.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 03:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795434859; x=1796039659; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o4oNKX9YSaQ7zR9YQ0CZmPGolVckVsLjzNRd1vRsTh0=;
        b=aDR0cqStTEihRwZEsSmsa6XB1TpawPSUw3WG8hfcd1rZt4wsLUvbCNNDEvjOr312Bj
         +aiCh52QdanhbFJdOMPpM5h6qFKK/QeLSHx7dDmt+U0VAIVE6dl6rGtHsmgiBsw8UEEi
         GVEn57Dw0nTOFh67U62W+bEwvIh41y8/lSA4avkkH+JsOhSelXUoeMMGhC4TsRrkbqVW
         ADBP5S52nKzsDYpZgqktVTOKaph9Q5EePtyHaughZ9Xj711Oc49AGpF2prImbkRAWYFJ
         MxrtP4H+a86LFwpz78EwkAAVfq0tebcLKZieYW+NIKKUJ93+p3af0jY9VKBPgjX5RMWx
         VbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795434859; x=1796039659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o4oNKX9YSaQ7zR9YQ0CZmPGolVckVsLjzNRd1vRsTh0=;
        b=06YjKs0ykoLfcr21c/FTJj5uJlPJMQv8tQp/y9NTaw6o9+KnYOBxYzppbPj/dIjktx
         2mBv7Cw8CPpgEXjalhglZySNSGVRb03bnAVsiBDwcO5Wgj1gPk8Y2xNcES1TwlzE5otl
         3mlg4VZLhWK0XoT3Aq1d2oWRM8FUQyituHDIQ0eP0cmSRQ84t7349KIglU1Zr8/yFnmn
         r36B2Bw+hlLbH7AyIzxVqpJ19a9gI7X80AbGZfaGOsfPyZetms4gEVRAH+Dx9pVtN42A
         mR6exbMGjn7B9RqfphpTRQjUjfQkKQgoSe8psGrskvmkSKGRm/cSCoqY9tKaUYcZX7kb
         ZSrQ==
X-Forwarded-Encrypted: i=1; AL+hErEatEoUx05lEGjQeNF+c7A9NdXH1EjPYMAb/urjgirbuv7AIaUUUoonGM2r9L7sqEXZnJsMQg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8U16yw1lOa6T4isbpHjbBIHMCn4XAe/yfkyv8ogiatSYJPjMsf
	FhLY+qGOvd6dZZHJEmdXFkB2xGzyiETy3YTn3FundGdEcpHMGnvgDsV6OWho4LYudIo=
X-Gm-Gg: AZFdTZdNulLjNja0UFwW4fMYMLRXvOxOuZWSXSqBx81wQ7dg9ruK5UiZjmlgq8rflsw
	CG39SsvJue2XjvBSUD3B04DmlOMpjGh44NCr5qiTBg7pr+g5q8wsIaR1uGGCnEW7avPdk5hkQf9
	TmfcXAj5rfmm6PDgow094tMUXyfLjM5wbc8whhEBjaHceslCyrB938tnM6Lc6kemP+xo+M7hX9c
	qK/g+h2FvGZy0+WHOZC/n6OzNl9EpLBes01xTqhB+FtwSH1BWPBpspBlL01ljs18MuySbHVZCPj
	TvmHKi6KEhSjKN0pa9UdBgVSajTJCHOzmAVsmvD21Gu3/cLfTB9HukO/40JcbQgJJ8bj1GSOgW/
	nuO8YN5pn+O7jWNMEcnehi2koN7e3ch5gl6uGpOt3F3xhhE/5TVXYbMc4wsQumx9UygGmtPfs9M
	MTzEvAstzcS/AjJrgRLB36JWNDCYv4ff0VrxEsnrUvbXamX0mUySQqa4gUtdiazVU1U6rhsOe8b
	kkeFl4SoVTpgLAL2MiuAQPHk5PTfMB0eIznnbas3LUCkrlAlD5UabP8nNDlV+I7EQZCeQtuM1Z/
	rBsPHwAAWOiht6hNbLG1e0I4yBtQ0KCoPoaYNL7FBdZguwwincWJcWZW6cVP3YM6z5/K
X-Received: by 2002:a05:693c:8803:20b0:386:9b9c:ef1b with SMTP id 5a478bee46e88-3869b9cf99amr7284369eec.3.1795434859156;
        Mon, 23 Nov 2026 03:54:19 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm35476837eec.23.2026.11.23.03.54.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 03:54:18 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 08/27] mm/damon/sysfs: implement report producer type and state files
Date: Mon, 23 Nov 2026 19:54:04 +0800
Message-ID: <20261123115411.8607-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121210013.130397-9-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org> <20261121210013.130397-9-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 21 Nov 2026 12:59:52 -0800 SJ Park <sj@kernel.org> wrote:

> Implement report_type and producer_state files under the report producer
> directory.  The type file receives the type of the reports that the
> producer will generate and submit to DAMON.  The producer_state file
> enables and disables the producer.

Makes sense, so LGTM.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>
