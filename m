Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8731E34CFC3
	for <damon@lists.linux.dev>; Wed, 22 Jul 2026 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728023; cv=none; b=CHEQCFwjyjkvZKFWZVdqaPq/dntFQHQbGHYHBqB7Ym17FTp+WLmtHPqjLj3kW8Bju7FQHhwdVwdjHP2rPYh0wfqKsJdnG5OLXd6fGDpUKilyEDsaBZzx7FiXfSNYK/NEqhIdfE9IGXUE+GBdW0SdYyvtPBm3iqvb0agFXDkMMDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728023; c=relaxed/simple;
	bh=CAaGrJYRRjMDaqotGs2bQ5uTqL7zJCWf+ZWL2787mCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tM3P38R0HK/jwOy4Rv1f0/pFoLBgnwJjOJI0E4hFmGUc9kZW8zbtHlCpekHVWPO+FkaVTk4MP0E9bck2tZYiebN7Q3HvYAwjs6Gk7LDHYK81SZMihT4euHbUeYb7QlrPOrK+OPL5GqeTJ/Pqrp+NHO77ifXph2V4nHWFB8ppN3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmWKKlyq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmWKKlyq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026C81F00A3E;
	Wed, 22 Jul 2026 13:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784728022;
	bh=TU1MQ7BeWFaTxBRrc9aQ1q6vtJ2v42CrYLRPX+haj9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mmWKKlyqqhYD320QJBZRm+9uE4C47XmP7jgW9+rLCD5lv3gtBmGDlLPrOWOMW1TX+
	 xN4zqiHMObOzhzKhC0t2LKfdeCa1fCHROrwY5i+bZekCZHAp8PgMlGSc6AkMgut/MP
	 HlnXERzuwdCpoWiXSCbQmoGIsp274iEpDZG60bCNoNM2JxIlpvzT7l6sjguBo/22yk
	 FO1fOV1xicUNJSjj6bmK7HFYxtpYjGg7dXSr85AFfpNkPRRcfE2r56G2hSvTUSMRO7
	 nlr8lUpsVmBW9pmvcDlU6CKw9VliA1/VzthryBVuuoHU4Qh67wvelcfy1VrrzC20oj
	 Rs7WoRKXVC/8g==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Enze Li <lienze@kylinos.cn>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH] samples/damon/mtier: add comment for struct region_range
Date: Wed, 22 Jul 2026 06:46:54 -0700
Message-ID: <20260722134655.87994-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721140619.297538-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 21 Jul 2026 07:06:18 -0700 SJ Park <sj@kernel.org> wrote:

> On Tue, 21 Jul 2026 15:07:56 +0800 Enze Li <lienze@kylinos.cn> wrote:
[...]
> This patch is applied to damon/next [1] tree.  If this patch is not added to
> mm.git in short term (~3 days?), I will ask mm.git maintainer (Andrew Morton)
> to pick this.  So, no action from your side is needed for now.  If it seems I
> also forgot doing that or you cannot wait for my action, please feel free to
> directly ask that to Andrew.
> 
> [1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


We (mm community) now want to focus on making mm.git more stabilized and
therefore ready for the next merge window, rather than adding more changes that
are not really urgent.  I agree and want to help [1] that.  For the reason,
unless Andre pick this first, I will request adding this to mm.git only after
next -rc1 release.  Let me know if you think this is really urgent.

[1] https://lore.kernel.org/20260722133829.87607-1-sj@kernel.org


Thanks,
SJ

[...]
