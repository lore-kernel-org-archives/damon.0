Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0068635C6B2
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 02:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789092095; cv=none; b=pUJ+c9k7ZJ6gBkNhB+Batwcmp9tpp/SrWYRK6dRRqssLa9dRBmoC7FBlyzqGdgPJaYfhFvItuegpsPT/uV2QOhPlfSgIiVQwHE2+u3jdEjdQoRzgiZZRWTp1dhIO1n+sTNaIXhJ9RS6swi0Z/N9f04HVlrjT1vdHSTJ8AmR50J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789092095; c=relaxed/simple;
	bh=lyKgnl1EihW2JrbG0ea9cQy8KQxBT0XDsfs/3jQTTME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjQL/o5H7IZMzT2S5UpR9x1PxplXz9DURvZX0y+T6ZUWhUnEvvoWFne1YIanzTKxvZyK/A9pmIjqmYcoLSX0h3TAucDMqjBul0sOhsceiCjQsNM3Tb+NTEgpbkKBe10NqpSVDZxXc0q88B16lJpwTBzFo/NRiIhoqCKWlwYHV0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8hs8BdC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8hs8BdC"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d6d28aa26cso2708375ad.2
        for <damon@lists.linux.dev>; Thu, 10 Sep 2026 19:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789092092; x=1789696892; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2lwngQ9rxT1ESSfCU2zsMXvsP+GFu2zW1k7zlPAhs8E=;
        b=L8hs8BdCTFAvYtxjKp80UACmmO6gJUqb40OxsJP66z7n1wIyUgK9nz1PQLScryeTxY
         jlAtHe0gPSWCLVQa/vFnt5uwtYCXGnjupKZM6C/Z7mRxt8exSO7xIkb3Y7blMBD37iE8
         iP7pszp0CizNwth2gHeCyoA6jgC7BS3q1RVjJSYKEmUt30JrVL1Sea4//R4fKbpcBG0i
         APvvEWqJOx3qt4cDvNTCp9QT35kIE+X4ob3bB4mJPXxFdkn3hO9k/n9rBb4l0kuOwSyd
         ifhbXdg1h76xTy7D6lT2cFGdDNPDzizDDxfobLWMi7eq15uw/gd95hOk/2SM5RcLevp/
         GyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789092092; x=1789696892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2lwngQ9rxT1ESSfCU2zsMXvsP+GFu2zW1k7zlPAhs8E=;
        b=pg5EFLnZiGy3z6JSMeMYHDFXuCmkevCYzyJ8EcJDFuBq1Gew4+jffWtsbeo3W+mVdN
         AfkFyGacyQTK9t5qjbc0H4JTXYMtQ5wjtkGysttsdqeFmgTk3B+A6jcHfo9tqCjQ4IPp
         vV36EiPxU0+Sh2WiQgh+9AJYleuCFdyULB3fBGQrccy+/uqPQtkufFRyFxk/RlQLEsup
         KoKi23ZoqdvnWxeGIVAQeypfDtrzQwnBNLGzKRkDq/L/qh1QjR6/Nt/ZsOu7MKT3DDhY
         +mVngpnaYRmeeLrpd6c9wT+0La0RLBXjjjV2Qa6ellW+jpH1530pQiiyr1XOWC9Ti/20
         gwtw==
X-Forwarded-Encrypted: i=1; AKwUvByLFTIsD/INn6mg9/XWC+42BA78BT4f/YpxtY54YT2pNsjPHKhXNHL8tEa9DK9Pv+hDxJHXNQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mpcKyEch+vgUPSKaN8hFW2sqVKmOErrb8+8V9VWfjiV7W6d83x
	3y6sEaZ4PcFDpBb9mM01GK3ydcUT25gkL5Kot0KKGXw4bgeQOGDcey7k
X-Gm-Gg: AYBFou0cQvtxutbmTaPpK7TYzl0z7E63xvdd31ZMr6R/NhVJog81KBmT+dGwH0gQB4j
	islkct/LHJnjP4dYIsas0kzOkN6oODWxFB9lcvEmA2SSpV9xGHHsBdaQ+oEAGecoJH5mvdDymJM
	EviMdhSvNA071Pc35sGuQMb5IY2jM2yNvSHc5Pgv3bCI1/gBJbXofcJkQANPTXIhObxoxQycQKA
	/Py7FE7/AJmwQSzstsEyO+WGcaUuFIDU8b9r+BkM4Fg8zvw3hT76eOAMsMqvZlJH+xdfUW6Dk2W
	RSpFbitvUIb4lY0W6pwQo0hT3F0dTIyZ5JpLnemVLx88xcvcKYcXl1e0YqEGBUZMztw8VFgLB2q
	bq5YNQ98o/c6kh66P3ipAzsYLErGfp4ghdRxNDtWP4Fi2kmLCpGqQUG1q8XK9+rxzOgeShJSohX
	lpfmZNSfCQiCoFg5XvxK+38rRo9Xp4eVMcWQvW0ZZ7aDWmUGp9+EE020cYEtis+cNaEUl9dNa45
	4OBWITy52kuMLsjJoCm2PIe9XvQp/Kd0toanRT4DX7ZrLHdiz8=
X-Received: by 2002:a17:903:1b04:b0:2d8:d4ce:9f37 with SMTP id d9443c01a7336-2dd2a470a45mr40913365ad.21.1789092092187;
        Thu, 10 Sep 2026 19:01:32 -0700 (PDT)
Received: from localhost.localdomain (vmi2317697.contaboserver.net. [85.239.239.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2dbb900asm3052615ad.74.2026.09.10.19.01.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 19:01:31 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH REPOST 5/5] mm/damon/vaddr: support pgidle_unset probe filter type
Date: Fri, 11 Sep 2026 10:01:10 +0800
Message-ID: <20260911020118.37585-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909140408.104699-6-sj@kernel.org>
References: <20260909140408.104699-1-sj@kernel.org> <20260909140408.104699-6-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 9 Sep 2026 07:04:07 -0700, SJ Park wrote:
> DAMON virtual address space operation set (vaddr) does not support
> pgidle_unset probe filter type.  Add the support.

This looks good to me.  Checking the PTE or PMD young state together
with the folio idle flag and MMU notifier state follows the existing
vaddr access-checking model while making it available to probes.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>

Thanks,
Lian
