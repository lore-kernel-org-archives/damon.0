Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CD33DA5B9
	for <damon@lists.linux.dev>; Tue, 19 May 2026 07:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779176044; cv=none; b=OSrqlMUMkhYexJZ+DxoqdM+a7M2raIaaf31s5iJKyXp17n4rY5BlzD0JDh/grFi2OBojZYLKbmVCCK8QJO7xyoYfNOlWeCUKp2U2sRFs6f+Ykd6RJt15W2ty2u37hJbEuh3lKx7NtlmF03KYun/p2Dvw1d3E6FsnVDE3zyc5W6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779176044; c=relaxed/simple;
	bh=Q8sRbbzeaOIcO4WgX9w/sPLDmiN17iIPXjvqTnre0mc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mVGZ4QX3JwiCbWpnGsR3ptBIMj1JPL1+Dj76yZS+rfackLDev8AdGHr2A9PxXOF6P+6YwGVHtWYPkDaklqtejl6lco2ltZt2cAWWxap9WgYg64FDSGWS3AYB0y0zePqt68Id6xDshjoezNdwqfJNswIKAxgHHuMoO50qGnenZ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r4v9jOK5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4v9jOK5"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so2764747f8f.0
        for <damon@lists.linux.dev>; Tue, 19 May 2026 00:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779176040; x=1779780840; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQEb3SnKmUgEZvX6aq8UF98SecrpTH59w1+qmzmaGdE=;
        b=r4v9jOK54yKSm4+NH8pIY6/LlpeixgdOiQDMOBxkYAYSdHJCycmWjwMbg/RPCirMvJ
         RKkkhHAvDydsoOXKCXF7xLz0J0/821LC1h7S8EzcodXth9wlQDILAnzq/PemjzQX/C1w
         7PL+gv2vehE3ADE6W16lYB0JVHS9KmUOMin4NHJEJpCmRHToMXMaa8bUR1209Sj/igUN
         +IqCXKCjSJBfbLsESRKjtxH8tE+h7ihWVrQ6ov7BBZo/Cna2J6J4D/VArgUKV/3oc00K
         NaFWem3FjH9QuEphHA3TjAHjdXtYBf0MwlzNX/N4enCgTkfix/YesSIUY4gAfyLAsdK1
         tzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779176040; x=1779780840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nQEb3SnKmUgEZvX6aq8UF98SecrpTH59w1+qmzmaGdE=;
        b=Z0b5cuez+VBcomL/vSLDV+kEHwlDmUwbHy23KQU1ItaDahto9DRr37LI5t2YKn3huz
         q0fCgXjnO8cbx4OzH0khnzp2jcv9kFhwDA7MTiHey4mX9cTv/hl/Pp/RW/mKHFL3yBQ4
         M5RwMjpr8UclE0zTo3IsN6oOEXTT39gkrWkWYAp1f/AmyEpBb8LBOG1QXMMZRWJKXPNW
         i9z3+9ORzqCybQy1KAyCLzSEgEOHFSMarMi7MEkP6uxbHvw92ja9G7lWD6lI8i1eYJa9
         7tvkFb99XzzmGmlMqu2/tavavkZsJl3DBEvy3/hSe8w++EUnb18RxPnArtgk8Zlg04fs
         wm7A==
X-Forwarded-Encrypted: i=1; AFNElJ9SFA07WMQdO2Xl4I2T/LMm/H3pkLpIwDSJ3pb+3vz8n1vXEm61zKV2jXiEIkktVxooHw0jqQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEOSmnPn/P1nTzcUe3ia1hQf3LlbxPZz/nUC81586//ZEA4vnb
	Gw3JHlv2UjI5XqKKYghUr8MdfeiWs+YD7jL031vk6OK82ATia7cGIPUr
X-Gm-Gg: Acq92OGGSUMXMTFrSp/yG4UVk5eyWPBtiwrkRUK5YT6W8neYYUYqcDT6zyMlI4/7Vgj
	JsHFxx4PJXSYkoM8jlR7yn95rNkwlDBCCPGfIJ9gtMAKX2/74d378ZGC8nvia8wxGDQ+6ThyMbv
	WvET4Oa27rPiEjVDzck0Rk1T6h/rCaliCZ45wfUpdJr7QikwVA4vhNgDzwY3YfoOGebiSP1dDT4
	N2srMBkdVlkDefW/Zp3WFkdIKevb7dqNgCN8K0TY+qQL9VnjGXvP4E0fPco05SJp2WhZ+zTBgXx
	93ut3rgWrm+vWUiDyn9plgOVPnGVuAJsNUxCQlO/FybQcj0tFeVTWsdJzDCYXW6n2mp+94dnElS
	xwO14ulb4nm3Zrd7BbyMzw9iHElEprjkiCpR1ujHuQ8EacdpxXfyjM86BqL8aV7TUj29kwE4hDT
	PRaMZKj3fx1Kx91CwvAjefU2euVl5ut/jRltZ6de6ui0fM+2KQtZM=
X-Received: by 2002:a05:600c:1d09:b0:48d:50a:6ef4 with SMTP id 5b1f17b1804b1-48fe537fb44mr240677305e9.11.1779176039621;
        Tue, 19 May 2026 00:33:59 -0700 (PDT)
Received: from mshcherba-RedmiBook-16.. ([188.163.115.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48ff43f8799sm191476755e9.2.2026.05.19.00.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 00:33:59 -0700 (PDT)
From: Maksym Shcherba <mshcherba2000@gmail.com>
X-Google-Original-From: Maksym Shcherba <maksym.shcherba@lnu.edu.ua>
To: SeongJae Park <sj@kernel.org>
Cc: Maksym Shcherba <maksym.shcherba@lnu.edu.ua>,
	Maksym Shcherba <mshcherba2000@gmail.com>,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/6] mm/damon/sysfs: implement update_schemes_quota_goals command
Date: Tue, 19 May 2026 10:33:52 +0300
Message-Id: <20260519073352.16587-1-maksym.shcherba@lnu.edu.ua>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519001703.99264-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 18 May 2026 17:17:02 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Mon, 18 May 2026 22:09:28 +0300 Maksym Shcherba <mshcherba2000@gmail.com> wrote:
> 
> > Add the logic to copy the current_value from the internal
> > damos_quota_goal structure to the damos_sysfs_quota_goal sysfs structure.
> > Introduce the DAMON_SYSFS_CMD_UPDATE_SCHEMES_QUOTA_GOALS command
> > and integrate it with the sysfs interface via the 'state' file.
> 
> Could you please further elaborate why you think this change is needed?  What
> is the expected use case and benefit?
>

Hi SJ,

The documentation (`Documentation/admin-guide/mm/damon/usage.rst`)
states that users can read the `current_value` file. However, the
kernel currently never updates this value in sysfs, preventing users
from reading the actual metrics.

This patch series implements the missing logic to align the code
with the documentation.

If the design intent was to intentionally keep `current_value`
internal and not expose it via sysfs, then the documentation is
incorrect. Let me know if that's the case, and I will send a v2
that drops the code changes and only fixes the documentation.

(Apologies for missing the cover letter where this should have
been explained, this is my first patch submission).

Thanks,
Maksym Shcherba

[...]
