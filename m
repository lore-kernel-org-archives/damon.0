Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5C83D79EF
	for <damon@lists.linux.dev>; Tue, 29 Sep 2026 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705648; cv=none; b=K7b6hpomu0zNBK5A8SVYIe7TVHbo/7ZC4uS2hnsaOkF7vphLolaFMGAKFBvgodixwaA+i3nKuWNg9UIclPawBevJAlKoFY0Ft/f2JjHaCh3BigJKh25qIyoXluRz4p/DlN8R1UWlu77A30p862qkQ0ylK9dEcVDhBukKRPXqFC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705648; c=relaxed/simple;
	bh=mZh9La+paKQR4zf/FQmxkRWHM4xhm7VufrGTHjDBftg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZyHzd+G+WgxSs0IsVeWsydZ7F3JZ7/161wl2ia7RIcSzkeqwyKteoFvhW0Am62EI+JFngBvFaRILORZ7+Qrdk5AgzCrOkUrzN2gA4CIs+LuAJ9DhlQI4FlKySa7KjZlgi4OWwSiUWkSQLBMZorJa2V7hdVjfEFoRPMtkVz2+omk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pratmal.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hJGPNSw/; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pratmal.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJGPNSw/"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33baaba6371so16767585eec.1
        for <damon@lists.linux.dev>; Tue, 29 Sep 2026 11:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790705644; x=1791310444; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mZh9La+paKQR4zf/FQmxkRWHM4xhm7VufrGTHjDBftg=;
        b=hJGPNSw/3Lg4R/yaRcrTjblK0vxwgxK/JTUDUJl1EX2svwiJlJ9XBplFFe2F1qrd7h
         vWjqayVd9Dsw3OWp43tcIzC7TvpcuZTBWVhaYc43pWwxtlyp1x+aw4EJDnwcGxMXKT0u
         sHmK6FOFXns5ugEErzoV1nWDeDVI+6Js8O4ENyWr2xEBv+x44PRrzicA/EWCUYtsd6OB
         Z+YVUuE69JwZ6N+tbPi4IYgSsIi3FMFKkfmSgEHooqXz4gWTg83phtICRTIaC1JAwV5e
         WgRsQy+GxMqYQLFEw7akyjyn92EpmUxna2zynEpHOY0EK+sYdCjPtl3OitAN5mhOZ/Ue
         VMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790705644; x=1791310444;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mZh9La+paKQR4zf/FQmxkRWHM4xhm7VufrGTHjDBftg=;
        b=m/vyypgMB8KeIFMF1CDh5SdLtD+Z4Ou5EVZOfFGdkL+kWMJbQftvDT2h1g9dtv48mb
         CYZ+I5/pLiDAvYt/VpyMLwHv6eXzD1tXXsoRyuTjtN74U2Xhr5rbr11LHg6Yfdt79TvR
         rQfdEcKGYfRS8fDB8nZ3Ec3wZDSYuJ3d8/9ZYOZsoX1Xlp+p5qTL8aEa5+GBRMiJBRYv
         1LmnAqtiqCfUPyf4CXyglFcdYsSIefBxzcDBeYtlQvkf9jWD+9BCw6rLcyCjXVIPjWZn
         akdSGZ2iqGs7BpmFvtsnq6Yiq3itcTn98sB6PasNJ5tBBnwVnnLBRYRNGu1xxaYvhGVD
         TQcQ==
X-Forwarded-Encrypted: i=1; AKwUvBxfDdu9o45NezjCV4rp3EJRdaRxPbgq1IWnJ5wLSpttrKXl6gBeL6Ql0r25SqSnd57RNe9I7A==@lists.linux.dev
X-Gm-Message-State: AFq9FYKxbqoP6iEtJdmM4wV3CSlJy8sCZ99v9iDTZRfhMJp1HXk4C6GI
	cmZNhak8iig/mcERQcqGum0O3euSwwp+qkdmdyrFu3++tAMj70JYwH2G5lu3O2sEGBwJKBiQdVZ
	zRkhNBgQcUw==
X-Received: from dybme43.prod.google.com ([2002:a05:7301:18ab:b0:34a:10b2:be3d])
 (user=pratmal job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:c8c8:b0:33c:e61:e201
 with SMTP id 5a478bee46e88-34c647d537fmr196806eec.22.1790705643313; Tue, 29
 Sep 2026 11:14:03 -0700 (PDT)
Date: Tue, 29 Sep 2026 18:14:02 +0000
In-Reply-To: <20260929123241.1408414-1-huang-jl@deepseek.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929123241.1408414-1-huang-jl@deepseek.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929181402.44684-1-pratmal@google.com>
Subject: Re: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
From: Pratyush Mallick <pratmal@google.com>
To: huang-jl@deepseek.com
Cc: baohua@kernel.org, damon@lists.linux.dev, david@kernel.org, 
	kunwu.chan@gmail.com, lance.yang@linux.dev, lianux.mm@gmail.com, 
	linux-mm@kvack.org, mst@redhat.com, ryncsn@gmail.com, sj@kernel.org, 
	virtualization@lists.linux.dev, xiang@kernel.org, xueyuan.chen21@gmail.com
Content-Type: text/plain; charset="UTF-8"

> We have not yet fully explored how best to tune the DAMON and free-page
> reporting parameters for our workloads.

You can also try tuning page_reporting_delay_ms, which can help you with
saving time-integrated host memory.

[1] https://lore.kernel.org/20260731193705.2902728-1-pratmal@google.com

Thanks,
Pratyush
