Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13989285CA2
	for <damon@lists.linux.dev>; Fri, 17 Apr 2026 04:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776400019; cv=none; b=Wyc0sdDm5tAEPuTWOIzJZyqM33g7mML00DVIIPgG0N3zEuWi7gBnWspebCUlmszSkVpFjIqHJ1baUryJIMI9yFk8PEroStqsIcLoh73F2ZFouyA1drGRiNOPf1mh6vE6OibNLUZdRC+A4cM3cvilp72n3cvOAXJ23hFgR4Wz0cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776400019; c=relaxed/simple;
	bh=Rzo3/lArtV5KZe4B53vpwZ2qNm0qXmGRIvm7UwEy+3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Se3cuGhd2kjq9Xd7jf5LDRIqCENtr5nBD7VVXj4Kn48mxwsU3M3b8bvzdypQ4xAkQ1i8V0lGNVHMJ6hluNS6SpnhtlxfyilO9Z/czoJpNA2lSRIAUWMECVASNac5ElpfVQ3xasB3wZU+zYSH3MdYs3G5CXXwfUOxgTYQocm6B3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2dbNlWB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2dbNlWB"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b24fede2acso1160745ad.3
        for <damon@lists.linux.dev>; Thu, 16 Apr 2026 21:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776400017; x=1777004817; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdZwKg7ZqT6fpMDssi0ujHMgVQlDq6enJyNYdZyrVCA=;
        b=d2dbNlWBlfOzzg0dWxw+rnMrdYijjhu/jSSxpPUcUsufuoAE5nZIY6/CwDrG7SCY3X
         Lz0ncJhTfX01Jmo50F5MuRlnTn3RX3wvVhTOk7siMI3fJABpMDYft1XNSMDXIlSe+TPB
         XxlduWs1yLj8U6DM2r/rrn4No1EDdZxfcD4seKKS1uzpoK4CMuJk7OrMMRs5lfg47U25
         VivqmbAbXjRurjXuSI0Cq8dv4pFIYmYbZ4kBuglwWNX/qPsCTAj8FNH7yH9RKjpLRxhN
         6s8gcugIQft+C/ETlFjPcJTk0/iXg4q9rIM2dh05Q8lFvsjeYTG2Klnqwd6jGYVdsJd+
         YlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776400017; x=1777004817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sdZwKg7ZqT6fpMDssi0ujHMgVQlDq6enJyNYdZyrVCA=;
        b=OZ9KRT+zvTWeP9xVdNdd1nF5z6nMtr4SnpaBGtVVicb7fGSfP1DNdmhZEQuKq+NxE7
         KnVZ/zyxV9EYEZCwyDqm+qgExxAkNVMtZqgXdcNrmvl3tf6hDdhLCghUpGqoSv6fZWcs
         g/ET1wxxcds7RPyBKsGvrO2c008DiA+loqUOY2GcpXHBExU8Cf7FgIxt+23bdIOBXdHm
         oTfy0zkzixcIh99UReMA47XKuD0KqZmPLk0/fSk+whPaMDjEsaGN7fL57qW/5cOw9+c7
         +ckpFiombZ0/00WeIW6WaQNKoKSgomGjA9JEjUnZnIw804g92EGB8QA6MqGM+u/KJE47
         Ddvg==
X-Forwarded-Encrypted: i=1; AFNElJ86cGPnniSvHZvdP51DzZ5yoaNRaLGMWmZLoFLlHs4/rQENqqU+d7p/Wth2XwGi3rDspyZQmg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxBoGwu46jA3p9TTGUlmqxorAkLlqWyOjEasdULjD69+q8vaHo
	F0eRuPL3t9/Ny/1KIQKGX0gQNR7U4TwBmZd68hft4ZHQUEDIqN7spOf6
X-Gm-Gg: AeBDievyNa49MK8RFKJmOW0sRh0phGSIVP4g4H7GYjwlhBgG7uIay7nFE4SRsMKQ7CR
	+b8b2YeKQ6kl+hwyLJnt3MSocJBfsrxOgPMptEtjMR7mgN58tQvUbhqF7DkLVsQGcCTkG2Mk6Cz
	mU1g3RFkQCiGxxd7vcy3COv7Eu3X5KsDBgXEwx+6k1YBGGGS3dVSpmJ+QBimPsP9LVXrCJNyBDk
	mgtj2OfCVLdjsyTuCMOPwBRkgLz6b1mDlCwxEbCrgq7wnbskEuJxn0488VKOINNd5XKyLV7b5zY
	dc2I4Bh7wC+B7nqhNRKvsWcm0xpjB/mQd7jQarfdTpjFwAr1MPQcLvYhz0+pgKhBelJSWYnH2pt
	2DSZFLWkHQzTUjp9QUoSAS1JVloprGM6qxXJLvuQk9GCMZbwd55nE8PyO6Nj5x8PWERlXjVW6Gc
	XKqlDYHIOhN7ihLsHbpXTIfZGqD+VodDYnnYiSW5QwDONhqCz3wxKq4REt6kwViYoWxQ==
X-Received: by 2002:a17:903:bd2:b0:2b2:ccfb:8387 with SMTP id d9443c01a7336-2b5f9f534d9mr10448305ad.28.1776400017244;
        Thu, 16 Apr 2026 21:26:57 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:889a:1f39:d795:a77d:4309:e1bb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0c17esm4928985ad.41.2026.04.16.21.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 21:26:56 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 0/2] mm/damon: reset thread status parameters upon kdamond termination
Date: Fri, 17 Apr 2026 12:27:01 +0800
Message-ID: <20260417042701.4077-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417011229.75947-1-sj@kernel.org>
References: <20260417011229.75947-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 16 Apr 2026 18:12:28 -0700 SeongJae Park <sj@kernel.org> wrote:

> Maybe I suggested too much...  If we decide to take both my suggested commit
> description and the above change direction, maybe it is difficult to say you
> are the main author who should be primarily responsible for any followup issues
> on the patch.  Of course you will still deserve to have credits.  Maybe
> 'Co-developed-by:'?

Yes, I've decide to adopt both your suggested commit description and the
implementation. Therefore, since you've done the most of the work, you
should be the main author of this patch.

> 
> Meanwhile, I feel like the fix of this bug is taking bit unnecessarily long
> time...

My apologies. I have had limited bandwidth recently.

> 
> If you agree, hence, I'd like to take this over from this point, and finish up
> the remaining works for this patch.  If you also agree, I will also take the
> responsibility (authorship) from you, while keeping keep your credits with
> 'Co-developed-by:' tag.  What do you think?

I agree to hand over this patch to you. Thank you for your help.

> 
> By the way, I hope I'm not making you to get me wrong.  I'm not trying to steal
> your credit (authorship).  In my opinion the authorship means the
> responsibility (or, who to blame) more than the credit.  Putting right name to
> the place for the responsibility is important for the long term maintenance and
> evolvement of the community and the product (Linux) in my opinion, so I have to
> say this.

Thank you for your explanation. I understand your point that authorship
implies responsibility, and since most of the core ideas for this patch
came from you, I fully agree that you should be the main author.

Best regards,
Rui Yan
