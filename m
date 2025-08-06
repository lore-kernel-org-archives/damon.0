Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE261C2335
	for <damon@lists.linux.dev>; Wed,  6 Aug 2025 03:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754451311; cv=none; b=dd7MYdoRDrmHJcQkkFyMxnZRsAyU5FPDn6Dgux15OfhAzUQRk5VAEXPSfq+qnHWbXHQMaZTjsBGtVr/QjfK54X5a9A4/H2ViyH//1/jim0ifBI4PQ+f1O5JtylNdEku9rAVn2M2pbWT1qe2tw3xM00YdccWqxKW4YtT1OS1XevE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754451311; c=relaxed/simple;
	bh=76itAxauKV3zop1wf1eT9hgZcPJ9MIuPrE4zZJLr5wA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kopnLIydKMrOv1r6CTu1FGl6Q+qeQdIlRLTpGrCGF8QYfRVbn3/JJ7AQi8ilqkgsMa5H9UbDR4AEmOP5bO4pCTzWT+SJmobpFTAfo2g+MVeIvKexgDtp3eOcGHrwBBQNcGZXNn/vSZlSRHxKHdQKK5URG+Vjj4B/tiXw44h0Jb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPJOVo83; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPJOVo83"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6195f7f9ad6so2216415eaf.3
        for <damon@lists.linux.dev>; Tue, 05 Aug 2025 20:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754451309; x=1755056109; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=76itAxauKV3zop1wf1eT9hgZcPJ9MIuPrE4zZJLr5wA=;
        b=RPJOVo83sEYHmXLhvRBuH03OS07FGy+SwSfSPZAlEVFrn5BkY1Gs+TWe+K1AP6suQL
         gvcczIVIr2gedd5yiM4PFXNU7m+JETCcwI82TIepZqtSDi5cJgTEq12GXAJq26K1j+o+
         VTfvjXStat6wP1BqmVV9pT6Qc7sHgCfigi4bd14rihfVfnipefAWklYoX0qXAshomoQh
         dcsG1KTHCwApcB0QYYs+ehisl3TLoH1SkWQA/MGKUTriLLdn3VPEyPGsNmbr34RbHOvE
         rj7zjY0HAdirzd73g8/ybXOM3Hstm3zoUBzxJiYKVtbOqUV6XOhiK1czFOW70G+3fyvy
         Pa6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754451309; x=1755056109;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=76itAxauKV3zop1wf1eT9hgZcPJ9MIuPrE4zZJLr5wA=;
        b=dgxn6MWU0vON/e+kBmelxcU4gSMLk+fYONOpgZ303gjXflSAKMFbbDMbttPvim52vk
         bgKEW/2Rb8W+0mqhwYU3obGELt8ZXFGJ++q3TdLx/QiccrwkhQg55wJrP2ox2bDs5VbR
         7wLyryaLSjkPmw4i1bl/seLwL21oZZxZnJx71rKfBKzmjaE5jRYXuei07CR1eZoRV3A4
         BPm58qFEWt0S34JT/yOSRRdZMCLvdpSWaTERPvwU33WBwFn+BLohsO7Y9WN0OM4yFGIf
         ghCsT+kBW+vmZmUgdZyNjqDwM1vljotZ8/t4ul1JE+KYluRbyq00O3zGE2u8ggeDjkjT
         P7HQ==
X-Gm-Message-State: AOJu0YwoGKOG7KBMXxnMd+7N8pfb67INHqiQ8+eGAM+eAxjYprqwVgXZ
	HoIBUBaZZysCAq1IlANnWgH/dhmv1xmQgLpkVMRlpzcPy4DWgw5xQin/diXyieENJ7sJfJWxXBv
	z1zOH/t7fn7rtepCUeIuSdwt+HN9UcFJBUbUx
X-Gm-Gg: ASbGnct4xsYakGy5996KyGLoQ3O1rRLghWnTLI1nsgngqKmFmgb85yc5RdfUrKthdH7
	Lzda8rm7hIm2CsBHLGPqNhTte7BTDEEDwoJK0ZUx4CMvUAm5pzYHaijm0VgL2h1U0Ynmv3+eZIM
	VYQEHvWKB62neHoDPDaIp8E80GPQYfZqJ5F/6JPFk1I5iJvoqIjYrxiK3Q15yq/tMdSLWTczRZw
	Rt7
X-Google-Smtp-Source: AGHT+IFJ5TImywGqU/fJCR10RxXgq3m+KIeY5mAFVUcjGdqGZJuNugcmoIB9fIs8udJJaVKMgN8MJMljwkgYYDD3ezc=
X-Received: by 2002:a05:6820:8c2:b0:615:a91b:8e7b with SMTP id
 006d021491bc7-61b5f32e2b9mr968761eaf.4.1754451308768; Tue, 05 Aug 2025
 20:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Wed, 6 Aug 2025 12:34:56 +0900
X-Gm-Features: Ac12FXxv410sdvKtTvNxVF2II6tDS9_TVC2JcMIXlEmigk0eCPCPT7m29YuRs6o
Message-ID: <CABFDxMFuqUbZ3fwOmZ1O42cicrBxa1s39w034W3W6ZnYmOu7kg@mail.gmail.com>
Subject: 
To: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

subscribe damon mailing list
